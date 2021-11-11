import 'basemodel.dart';
import 'cartao_credito_model.dart';
import 'categoria_model.dart';

class SaidaModel extends BaseModel {
  final String descricao;
  final double valor;
  DateTime? data;
  List<CategoriaModel>? categorias;
  CartaoCreditoModel? cartaoCredito;

  SaidaModel({
    int? id,
    required this.descricao,
    required this.valor,
    DateTime? data,
    List<CategoriaModel>? categorias,
    CartaoCreditoModel? cartaoCredito,
  }) : super(id: id);

  SaidaModel.fromJson(Map<String, dynamic> data)
      : descricao = data['descricao'],
        valor = data['valor'],
        data = DateTime.parse(data['data']),
        super(id: data['id']) {
    categorias = [];
    for (Map<String, dynamic> categoria in data['categorias']) {
      categorias!.add(CategoriaModel.fromJson(categoria));
    }

    if (data.containsKey('cartaoCredito')) {
      cartaoCredito = CartaoCreditoModel.fromJson(data['cartaoCredito']);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'descricao': descricao,
      'valor': valor,
      'data': data.toString(),
      'cartaoCredito': cartaoCredito?.toJson(),
    };

    List<Map<String, dynamic>> jsonCategorias = [];
    for (CategoriaModel categoria in categorias!) {
      jsonCategorias.add(categoria.toJson());
    }

    json.addAll(super.toJson());
    json.addAll({'categorias': jsonCategorias});
    return json;
  }
}
