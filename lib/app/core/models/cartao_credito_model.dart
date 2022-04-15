import 'package:flutter/material.dart';

import 'basemodel.dart';

class CartaoCreditoModel extends BaseModel {
  final String nome;
  final Color cor;

  CartaoCreditoModel({
    int? id,
    required this.nome,
    Color? cor,
  })  : cor = cor ?? Colors.white,
        super(id: id);

  CartaoCreditoModel.fromJson(Map<String, dynamic> data)
      : nome = data['nome'],
        cor = Color(data['cor']),
        super(id: data['id']);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'nome': nome,
      'cor': cor.value,
    };

    json.addAll(super.toJson());
    return json;
  }

  @override
  String toString() {
    return nome;
  }
}
