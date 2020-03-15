 
import 'dart:io';
import 'package:excel/excel.dart';

final List<String> titles = ["CARRERAS", "INGENIERÍA", "GESTIÓN", "CIENCIAS", "TURNO", "SECCIÓN"];
final Map<String, List<Enfasis>> enfasis = {
  "LCIk": [Enfasis("ASI", "Análisis de Sistemas Informáticos"), Enfasis("PC", "Programación de Computadoras")],
  "IEK": [Enfasis("EM", "Electrónica Médica"), Enfasis("TI", "Teleprocesamiento de la Información"), Enfasis("CI", "Control Industrial"), Enfasis("MEC", "Mecatrónica")],
  "LGH": [Enfasis("G", "Gastronomía"), Enfasis("H", "Hotelería"), Enfasis("T", "Turismo")]
};

void main(){
  File file = File("Horario_clases_examenes_Primer_Periodo_28022020.xlsx");
  var bytes = file.readAsBytesSync();
  var decoder = Excel.decodeBytes(bytes, update: true);
  List<Carrera> carreras = getCarreras(decoder);
  List<Semestre> asignaturasPorSemestre = getAsignaturasPorSemestreYCarrera(decoder, carreras[15]);
  print(asignaturasPorSemestre);
}

List<Semestre> getAsignaturasPorSemestreYCarrera(Excel decoder, Carrera carrera){
  List<dynamic> rows = decoder.tables[carrera.codigo].rows;
  rows = rows.sublist(11);
  List<Semestre> semestres = List();
  for(var row in rows){
    if(existSemestre(int.parse(row[4].toString()), semestres)){
      Semestre semestre = getSemestre(semestres, int.parse(row[4].toString()));
      if(!existsAsignatura(semestre.asignaturas, row[2])){
        Asignatura asignatura = Asignatura();
        asignatura.nombre = row[2];
        semestre.asignaturas.add(asignatura);
      }
    }
    else {
      Semestre semestre = Semestre();
      semestre.numero = int.parse(row[4].toString());
      List<Asignatura> asignaturas = List();
      Asignatura asignatura = Asignatura();
      asignatura.nombre = row[2];
      asignaturas.add(asignatura);
      semestre.asignaturas = asignaturas;
      semestres.add(semestre);
    }
  }
  semestres.sort((a, b) => a.numero > b.numero ? 1 : 0);
  return semestres;
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

List<Carrera> getCarreras(Excel decoder){
  List<Carrera> carreras = List();
  for(var table in decoder.tables.keys){
    if(table == "Códigos"){
      String title = null;
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

class Carrera {
  String nombre;
  String codigo;
  Enfasis enfasis;
  
  @override
  String toString(){
    return "$codigo, ${enfasis != null ? enfasis.codigo : null}, $nombre\n";
  }
}

class Enfasis {

  String nombre;
  String codigo;

  Enfasis(String codigo, String nombre){
    this.nombre = nombre;
    this.codigo = codigo;
  }  

  @override
  String toString(){
    return "$codigo, $nombre\n";
  }  
}

class Semestre {
  int numero;
  List<Asignatura> asignaturas;

  @override
  String toString(){
    return "$numero: $asignaturas\n";
  }
}

class Asignatura {
  String nombre;

  @override
  String toString(){
    return "$nombre";
  }

}

  