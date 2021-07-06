import 'model.dart';
import 'categoria.dart';
import 'cartao_credito.dart';

class Saida extends Model {
  final String _descricao;
  final double _valor;
  DateTime? _data;
  List<Categoria>? _categorias;
  CartaoCredito? _cartaoCredito;

  Saida(int id, this._descricao, this._valor,
      {DateTime? data, List<Categoria>? categorias, CartaoCredito? cartaoCredito})
      : super(id) {
    this._data = data;
    this._categorias = categorias;
    this._cartaoCredito = cartaoCredito;
  }

  CartaoCredito? get cartaoCredito => _cartaoCredito;

  List<Categoria>? get categorias => _categorias;

  DateTime? get data => _data;

  double get valor => _valor;

  String get descricao => _descricao;
}
