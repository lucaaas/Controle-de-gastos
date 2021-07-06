import 'package:flutter/cupertino.dart';

import 'model.dart';

class CartaoCredito extends Model {
  final String _nome;
  final Color _cor;

  CartaoCredito(int id, this._nome, this._cor) : super(id);

  Color get cor => _cor;

  String get nome => _nome;
}
