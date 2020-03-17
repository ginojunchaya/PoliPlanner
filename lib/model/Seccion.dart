import 'Docente.dart';

class Seccion {
  Docente docente;
  String nombre;
  String turno;
  Map<String, String> horarios;

  @override
  String toString() => "$turno $nombre $docente $horarios";

}