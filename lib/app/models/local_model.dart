import 'dart:convert';

class LocalModel {
  int? contador;
  String? descricao;
  int? limite;
  String? data;
  LocalModel({
    this.contador,
    this.descricao,
    this.limite,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'contador': contador,
      'descricao': descricao,
      'limite': limite,
      'data': data,
    };
  }

  factory LocalModel.fromMap(Map<String, dynamic> map) {
    return LocalModel(
      contador: map['contador']?.toInt(),
      descricao: map['descricao'],
      limite: map['limite']?.toInt(),
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalModel.fromJson(String source) =>
      LocalModel.fromMap(json.decode(source));
}
