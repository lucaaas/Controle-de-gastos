import 'package:flutter/cupertino.dart';

import 'model.dart';

class Categoria extends Model {
  final String _nome;
  final String _descricao;
  final String _cor;

  Categoria(id, this._nome, this._descricao, this._cor) : super(id);

  String get cor => _cor;

  String get descricao => _descricao;

  String get nome => _nome;
}
