import 'model.dart';
import 'categoria.dart';

class Entrada extends Model {
  final String _descricao;
  final double _valor;
  DateTime _data;
  List<Categoria> _categorias;

  Entrada(int id, this._descricao, this._valor,
      {DateTime data, List<Categoria> categorias})
      : super(id) {
    this._data = data;
    this._categorias = categorias;
  }

  List<Categoria> get categorias => _categorias;

  DateTime get data => _data;

  double get valor => _valor;

  String get descricao => _descricao;
}
