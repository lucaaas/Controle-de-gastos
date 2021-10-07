import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'basemodel.dart';

class CartaoCreditoModel extends BaseModel {
  final String nome;
  final Color cor;

  CartaoCreditoModel({int? id, required this.nome,  this.cor = Colors.white}) : super(id: id);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'nome': nome,
      'cor': cor.value,
    };

    json.addAll(super.toJson());
    return json;
  }
}