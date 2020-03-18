import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Docente {
  String nombres;
  String apellidos;

  Docente(String nombres, String apellidos){
    this.nombres = nombres;
    this.apellidos = apellidos;
  }

  Docente.fromJson(Map<String, dynamic> json)
    : nombres = json['nombres'],
      apellidos = json['apellidos'];

  Map<String, dynamic> toJson() => _$DocenteToJson(this);  

  Map<String, dynamic> _$DocenteToJson(Docente instance) => <String, dynamic>{
    'nombres': instance.nombres,
    'apellidos': instance.apellidos
  };  

  @override
  String toString() => "$nombres $apellidos";

}