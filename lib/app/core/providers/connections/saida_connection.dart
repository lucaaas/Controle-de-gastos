import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/saida_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/providers/connections/transaction_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaidaConnection extends TransactionConnection {
  final DBHelper _dbHelper;
  final CartaoCreditoConnection _cartaoCreditoConnection;

  SaidaConnection(this._dbHelper, this._cartaoCreditoConnection);

  Future<Map<CartaoCreditoModel, double>> getCreditCardsBalance() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> result = await database.getData(
      table: table,
      columns: ['cartao_credito, SUM(valor) AS total'],
      where: 'data BETWEEN ? AND ? AND cartao_credito IS NOT NULL',
      whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
      groupBy: 'cartao_credito',
      orderBy: 'total desc',
    );

    Map<CartaoCreditoModel, double> creditCardsBalance = {};
    for (Map<String, dynamic> row in result) {
      CartaoCreditoModel cartaoCredito = await _cartaoCreditoConnection.get(row['cartao_credito']);
      creditCardsBalance[cartaoCredito] = row['total'];
    }

    return creditCardsBalance;
  }

  @override
  Future<MessageType> insert(SaidaModel model) async {
    try {
      MessageType messageInsert = await super.insert(model);
      if (messageInsert.level == MessageLevel.success) {
        for (CategoriaModel categoria in model.categorias ?? []) {
          saveCategoria(categoria.id!, messageInsert.data!['id']);
        }
      }

      return messageInsert;
    } catch (e, stacktrace) {
      delete(model);

      throw Exception(
        MessageType(
          level: MessageLevel.error,
          message: 'Não foi possível salvar $table: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  @override
  DBHelper get database => _dbHelper;

  @override
  String get table => 'saida';

  Future<CartaoCreditoModel> _getCartaoCredito(int idCartao) async {
    return await _cartaoCreditoConnection.get(idCartao);
  }

  @override
  Future<TransactionModel> rowToModel(Map<String, dynamic> row) async {
    Map<String, dynamic> data = row.map((key, value) => MapEntry(key, value));

    data['categorias'] = await getCategorias(data['id']);
    if (data['cartao_credito'] != null) {
      data['cartaoCredito'] = await _getCartaoCredito(data['cartao_credito']);
    }

    return SaidaModel.fromJson(data);
  }

  @override
  String get tableCategoriaTransaction => 'saida_possui_categoria';
}

final $SaidaConnection = BindInject((i) => SaidaConnection(i.get(), i.get()));
