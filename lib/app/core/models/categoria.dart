import 'package:controlegastos/app/core/models/basemodel.dart';

class Categoria extends BaseModel {
  final String _nome;
  final String _descricao;
  final int _cor;

  Categoria(id, this._nome, this._descricao, this._cor) : super(id: id);

  int get cor => _cor;

  String get descricao => _descricao;

  String get nome => _nome;
}
