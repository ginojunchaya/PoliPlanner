import 'Docente.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Seccion {
  Docente docente;
  String nombre;
  String turno;
  Map<String, String> horarios;
  bool selected;

  Seccion(){
    this.selected = false;
  }

  Seccion.fromJson(Map<String, dynamic> json){
    docente = Docente.fromJson(json['docente']);
    nombre = json['nombre'];
    turno = json['turno'];
    Map<String, dynamic> horariosDyn = json['horarios'];
    horarios = Map();
    horariosDyn.forEach((key, value) { 
      horarios.putIfAbsent(key, () => value);
    });
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() => _$SeccionToJson(this);  

  Map<String, dynamic> _$SeccionToJson(Seccion instance) => <String, dynamic>{
    'docente': instance.docente,
    'nombre': instance.nombre,
    'turno': instance.turno,
    'horarios': instance.horarios,
    'selected': instance.selected,
  };  

  @override
  String toString() => "$turno $nombre $docente $horarios";

}