import 'dart:io';

import 'package:excel/excel.dart';
import 'package:poliplanner/model/Asignatura.dart';
import 'package:poliplanner/model/Carrera.dart';
import 'package:poliplanner/model/Docente.dart';
import 'package:poliplanner/model/Enfasis.dart';
import 'package:poliplanner/model/Seccion.dart';
import 'package:poliplanner/model/Semestre.dart';

class XlsManager {

  File file;
  Excel decoder;

  final List<String> titles = ["CARRERAS", "INGENIERÍA", "GESTIÓN", "CIENCIAS", "TURNO", "SECCIÓN"];
  final Map<String, List<Enfasis>> enfasis = {
    "LCIk": [Enfasis("ASI", "Análisis de Sistemas Informáticos"), Enfasis("PC", "Programación de Computadoras")],
    "IEK": [Enfasis("EM", "Electrónica Médica"), Enfasis("TI", "Teleprocesamiento de la Información"), Enfasis("CI", "Control Industrial"), Enfasis("MEC", "Mecatrónica")],
    "LGH": [Enfasis("G", "Gastronomía"), Enfasis("H", "Hotelería"), Enfasis("T", "Turismo")]
  };
  
  void openFile(file){
    this.file = file;
    var bytes = file.readAsBytesSync();
    this.decoder = Excel.decodeBytes(bytes, update: true);
    print(this.decoder.tables);
  }

  List<Semestre> getSemesters(Excel decoder, Carrera carrera){
    List<dynamic> rows = decoder.tables[carrera.codigo].rows;
    rows = rows.sublist(11);
    List<Semestre> semestres = List();
    for(var row in rows){
      if(existSemestre(int.parse(row[4].toString()), semestres)){
        Semestre semestre = getSemestre(semestres, int.parse(row[4].toString()));
        if(!isEnfasis(carrera.enfasis, row[6])){
          continue;
        }
        if(!existsAsignatura(semestre.asignaturas, row[2])){
          Seccion seccion = Seccion();
          seccion.docente = Docente(row[12], row[11]);
          seccion.turno = row[8];
          seccion.nombre = row[9];
          seccion.horarios = {
            "LUNES": row[26],
            "MARTES": row[28],
            "MIÉRCOLES": row[30],
            "JUEVES": row[32],
            "VIERNES": row[34],
            "SÁBADO": row[36]
          };
          Asignatura asignatura = Asignatura();
          asignatura.secciones = List();
          asignatura.secciones.add(seccion);
          asignatura.nombre = row[2];
          semestre.asignaturas.add(asignatura);
        }
        else {
          Asignatura asignatura = getAsignatura(semestre.asignaturas, row[2]);
          Seccion seccion = Seccion();
          seccion.docente = Docente(row[12], row[11]);
          seccion.turno = row[8];
          seccion.nombre = row[9];
          seccion.horarios = {
            "LUNES": row[26],
            "MARTES": row[28],
            "MIÉRCOLES": row[30],
            "JUEVES": row[32],
            "VIERNES": row[34],
            "SÁBADO": row[36]
          };
          asignatura.secciones.add(seccion);
        }
      }
      else {
        Semestre semestre = Semestre();
        semestre.numero = int.parse(row[4].toString());
        List<Asignatura> asignaturas = List();
        Seccion seccion = Seccion();
        seccion.docente = Docente(row[12], row[11]);
        seccion.turno = row[8];
        seccion.nombre = row[9];
        seccion.horarios = {
          "LUNES": row[26],
          "MARTES": row[28],
          "MIÉRCOLES": row[30],
          "JUEVES": row[32],
          "VIERNES": row[34],
          "SÁBADO": row[36]
        };  
        Asignatura asignatura = Asignatura();
        asignatura.nombre = row[2];
        asignatura.secciones = List();
        asignatura.secciones.add(seccion);
        asignaturas.add(asignatura);
        semestre.asignaturas = asignaturas;
        semestres.add(semestre);
      }
    }
    semestres.sort((a, b) => a.numero > b.numero ? 1 : 0);
    return semestres;
  }

  bool isEnfasis(Enfasis enfasis, String element){
    if(enfasis == null){ return true; }
    if(element == null || element.contains("-")){
      return true;
    }
    if(element == enfasis.codigo){ return true; }
    return false;
  }

  Asignatura getAsignatura(List<Asignatura> asignaturas, String value){
    for(Asignatura asignatura in asignaturas){
      if(asignatura.nombre == value){
        return asignatura;
      }
    }
    return null;  
  }

  bool existsAsignatura(List<Asignatura> asignaturas, String value){
    for(Asignatura asignatura in asignaturas){
      if(asignatura.nombre == value){
        return true;
      }
    }
    return false;
  }

  Semestre getSemestre(List<Semestre> semestres, int numero){
    for(Semestre semestre in semestres){
      if(semestre.numero == numero){
        return semestre;
      }
    }
    return null;
  }

  bool existSemestre(int element, List<Semestre> list){
    for(Semestre semestre in list){
      if(element == semestre.numero){
        //print("Is true");
        return true;
      }
    }
    return false;
  }  

  List<Carrera> getCarrer(){
    if(this.decoder == null){ throw Exception("No se ha cargado el archivo"); } 
    List<Carrera> carreras = List();
    for(var table in decoder.tables.keys){
      if(table == "Códigos"){
        String title;
        for (var row in decoder.tables[table].rows) {
          if(!containsNull(row) || isTitle(row)){
            if(!containsHeader(row)){
              if(isTitle(row)){
                title = row[0];
                continue;
              }
              if(isValidTitle(title)){
                Carrera carrera = new Carrera();
                carrera.codigo = row[0];
                carrera.nombre = row[1];
                carreras.add(carrera);
              }
            }
          }
        }
        break;
      }
    }
    List<Carrera> carrerasAll = List();
    for(Carrera carrera in carreras){
      if(enfasis.containsKey(carrera.codigo)){
        List<Enfasis> list = getEnfasisByCarrera(carrera.codigo);
        for(Enfasis enf in list){
          Carrera entity = Carrera();
          entity.codigo = carrera.codigo;
          entity.nombre = carrera.nombre;
          entity.enfasis = enf;
          carrerasAll.add(entity);
        }
      }
      else {
        Carrera entity = carrera;
        carrerasAll.add(entity);
      }
    }
    return carrerasAll;    
  }

  List<Enfasis> getEnfasisByCarrera(codigo){
    List<Enfasis> list = List();
    enfasis.forEach((key, value) {
      if(key == codigo){
        list = value;
      }
    });
    return list;
  }

  bool isValidTitle(String title){
    if(title == null){ return false;}
    if(title.contains("CARRERA")){
      return true;
    }
    return false;
  }

  bool isTitle(List<dynamic> row){
    for(var element in row){
      if(element == null){ continue; }    
      String stringElement = element;
      for(String title in titles){
        if(stringElement.contains(title)){ return true; }
      }
    }
    return false;
  }

  bool containsNull(List<dynamic> row){
    for(var element in row){
      if(element == null) { return true; }
    }
    return false;
  }

  bool containsHeader(List<dynamic> row){
    for(var element in row){
      if(element == null){ continue; }
      String stringElement = element;
      if(stringElement.contains("Código") || stringElement.contains("Departamento")){
        return true;
      }
    }
    return false;
  }

  bool isLoaded() => decoder == null ? false : true;

}