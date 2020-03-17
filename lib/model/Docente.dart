class Docente {
  String nombres;
  String apellidos;

  Docente(String nombres, String apellidos){
    this.nombres = nombres;
    this.apellidos = apellidos;
  }

  @override
  String toString() => "$nombres $apellidos";

}