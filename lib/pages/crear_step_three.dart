import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poliplanner/core/xls-manager.dart';
import 'package:poliplanner/model/Asignatura.dart';
import 'package:poliplanner/model/Seccion.dart';
import 'package:poliplanner/widgets/side_menu.dart';
import 'package:poliplanner/widgets/title.dart';

class CrearStepThree extends StatefulWidget {

  const CrearStepThree(List<Asignatura> asignaturas, Function(List<Asignatura>) save) : this.asignaturas = asignaturas, this.save = save;
  final List<Asignatura> asignaturas;
  final Function(List<Asignatura> asignaturas) save;

  @override
  CrearStepThreeState createState() => CrearStepThreeState();

}

class CrearStepThreeState extends State<CrearStepThree> {

  List<Asignatura> asignaturas;

  @override
  void initState(){
    this.asignaturas = widget.asignaturas;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CupertinoButton(
            child: Icon(
              Icons.menu,
              color: Colors.black87
            ),
            onPressed:(){ ScaffoldState().openDrawer(); }
          ),
          backgroundColor: Colors.white,
          title: CustomTitle(text: "Crear horario")
        ),
        drawer: SideMenu(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Text("Paso 3: Selecciona las secciones"),
                padding: EdgeInsets.all(15),
                color: Color(0xfff4f4f4),
                width: double.infinity,
              ),
              Expanded(
                child: ListView(
                  children: asignaturas.map((a) => ExpansionTile(
                    title: Text("${a.nombre}"),
                    children: a.secciones.map((s) => ListTile(
                      title: Text("${s.nombre} - ${s.docente}", style: TextStyle(fontSize: 15)),
                      trailing: Checkbox(value: s.selected, tristate: false, onChanged:(e){ this.changeSeccionCheck(e, a, s); }),
                    )).toList(),
                  )).toList()
                )
              )
            ]
          )
        ),
        bottomSheet: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: Icon(Icons.arrow_back),
                onPressed: back
              ),
              CupertinoButton(
                child: Icon(Icons.arrow_forward),
                onPressed: next,
              )
            ],
          ),
        ),
    );
  }

  changeSeccionCheck(e, Asignatura asignatura, Seccion seccion){
    this.setState(() {
      List<Seccion> seccionesAux = asignatura.secciones;
      for(Seccion s in seccionesAux){
        if(s.nombre == seccion.nombre){
          s.selected = !s.selected;
        }
        else{
          s.selected = false;
        }
      }
      asignatura.secciones = seccionesAux;
    });
  }

  back(){
    Navigator.pop(context);
  }

  next(){
    //save
    widget.save(asignaturas);
    Navigator.pushReplacementNamed(context, "home");
  }

}