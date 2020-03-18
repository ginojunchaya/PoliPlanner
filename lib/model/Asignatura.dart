import 'Seccion.dart';

class Asignatura {
  String nombre;
  List<Seccion> secciones;
  bool selected;

  Asignatura(){
    this.selected = false;
  }

  @override
  String toString() => "$nombre $secciones";

}