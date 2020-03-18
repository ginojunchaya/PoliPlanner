import 'Asignatura.dart';

class Semestre {
  int numero;
  List<Asignatura> asignaturas;
  bool selected;

  Semestre(){
    this.selected = false;
  }

  @override
  String toString() => "$numero: $asignaturas";

}