import 'Seccion.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Asignatura {
  String nombre;
  List<Seccion> secciones;
  bool selected;

  Asignatura(){
    this.selected = false;
  }

  @override
  String toString() => "$nombre $secciones";

  Map<String, dynamic> toJson() => _$AsignaturaToJson(this);  

  Asignatura.fromJson(Map<String, dynamic> json){
    nombre = json['nombre'];
    List<dynamic> seccionesDyn = json['secciones'];
    secciones = seccionesDyn.map((e) => Seccion.fromJson(e)).toList();
    selected = json['selected'];
  }

  Map<String, dynamic> _$AsignaturaToJson(Asignatura instance) => <String, dynamic>{
    'nombre': instance.nombre,
    'secciones': instance.secciones,
    'selected': instance.selected,
  };

}