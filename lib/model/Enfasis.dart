class Enfasis {

  String nombre;
  String codigo;

  Enfasis(String codigo, String nombre){
    this.nombre = nombre;
    this.codigo = codigo;
  }  

  @override
  String toString() => nombre != null ? nombre : "";

}