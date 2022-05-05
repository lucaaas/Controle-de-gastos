import 'package:controlegastos/app/core/models/transaction_model.dart';

import 'categoria_model.dart';

class EntradaModel extends TransactionModel {
  EntradaModel({
    int? id,
    required String descricao,
    required double valor,
    DateTime? data,
    List<CategoriaModel>? categorias,
  }) : super(id: id, descricao: descricao, valor: valor, data: data, categorias: categorias);

  EntradaModel.fromJson(Map<String, dynamic> data)
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
  }
}
