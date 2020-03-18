import 'Enfasis.dart';

class Carrera {
  String nombre;
  String codigo;
  Enfasis enfasis;
  bool selected;

  Carrera(){
    this.selected = false;
  }
  
  @override
  String toString(){
    return "$codigo, ${enfasis != null ? enfasis.codigo : null}, $nombre";
  }
}