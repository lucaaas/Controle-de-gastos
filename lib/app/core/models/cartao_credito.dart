import 'package:controlegastos/app/core/models/basemodel.dart';
import 'package:flutter/material.dart';

class CartaoCredito extends BaseModel {
  final String _nome;
  final Color _cor;

  CartaoCredito(int id, this._nome, this._cor) : super(id: id);

  Color get cor => _cor;

  String get nome => _nome;
}
