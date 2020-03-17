import 'Seccion.dart';

class Asignatura {
  String nombre;
  List<Seccion> secciones;

  @override
  String toString() => "$nombre $secciones";

}