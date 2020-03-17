import 'Enfasis.dart';

class Carrera {
  String nombre;
  String codigo;
  Enfasis enfasis;
  
  @override
  String toString(){
    return "$codigo, ${enfasis != null ? enfasis.codigo : null}, $nombre";
  }
}