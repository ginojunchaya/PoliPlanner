import 'Asignatura.dart';

class Semestre {
  int numero;
  List<Asignatura> asignaturas;

  @override
  String toString() => "$numero: $asignaturas";

}