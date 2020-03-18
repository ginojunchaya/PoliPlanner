import 'Docente.dart';

class Seccion {
  Docente docente;
  String nombre;
  String turno;
  Map<String, String> horarios;
  bool selected;

  Seccion(){
    this.selected = false;
  }

  @override
  String toString() => "$turno $nombre $docente $horarios";

}