import 'package:flutter/material.dart';

import 'basemodel.dart';

class CategoriaModel extends BaseModel {
  final String nome;
  final String? descricao;
  final Color cor;

  CategoriaModel({
    int? id,
    required this.nome,
    this.descricao,
    this.cor = Colors.white,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'nome': nome,
      'descricao': descricao,
      'cor': cor.value,
    };

    json.addAll(super.toJson());
    return json;
  }
}