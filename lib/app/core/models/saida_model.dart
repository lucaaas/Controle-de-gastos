import 'package:controlegastos/app/core/models/transaction_model.dart';

import 'cartao_credito_model.dart';
import 'categoria_model.dart';

class SaidaModel extends TransactionModel {
  CartaoCreditoModel? cartaoCredito;

  SaidaModel({
    int? id,
    required String descricao,
    required double valor,
    DateTime? data,
    List<CategoriaModel>? categorias,
    this.cartaoCredito,
  }) : super(id: id, descricao: descricao, valor: valor, data: data, categorias: categorias);

  SaidaModel.fromJson(Map<String, dynamic> data)
      : super(
          descricao: data['descricao'],
          valor: data['valor'],
          data: DateTime.parse(data['data']),
          id: data['id'],
        ) {
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
      'cartao_credito': cartaoCredito?.id,
    };

    json.addAll(super.toJson());
    return json;
  }
}
