import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/saida_model.dart';
import 'package:controlegastos/app/core/providers/connections/baseconnector.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaidaConnection extends BaseConnector {
  final DBHelper _dbHelper;
  final CartaoCreditoConnection _cartaoCreditoConnection;

  SaidaConnection(this._dbHelper, this._cartaoCreditoConnection);

  @override
  Future<SaidaModel> get(int id) async {
    try {
      Map<String, dynamic> data = await database.getDataById(table: table, id: id);
      data['categorias'] = _getCategorias(id);
      SaidaModel saidaModel = SaidaModel.fromJson(data);

      if (data.containsKey('cartao_credito')) {
        saidaModel.cartaoCredito = await _getCartaoCredito(data['cartao_credito']);
      }

      return saidaModel;
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.error,
          message: 'Não foi possível recuperar registro de $table: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  @override
  Future<List<SaidaModel>> getAll() async {
    try {
      List<Map<String, dynamic>> rows = await database.getData(table: table);

      List<SaidaModel> saidas = await _mapToModel(rows);

      return saidas;
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.error,
          message: 'Não foi possível recuperar registro de $table: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  Future<double> getAvailableBalance() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> result = await database.getData(
      table: table,
      columns: ['SUM(valor) AS total'],
      where: 'data BETWEEN ? AND ? AND cartao_credito IS NULL',
      whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
    );

    return result[0]['total'] ?? 0.0;
  }

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

  Future<double> getFutureBalance() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> result = await database.getData(
      table: table,
      columns: ['SUM(valor) AS total'],
      where: 'createdAt BETWEEN ? AND ?',
      whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
    );

    return result[0]['total'] ?? 0.0;
  }

  Future<List<SaidaModel>> getLasts() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> rows = await database.getData(
      table: table,
      where: 'data BETWEEN ? AND ? AND cartao_credito IS NULL',
      whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
      limit: 3,
      orderBy: 'data desc'
    );

    List<SaidaModel> saidas = await _mapToModel(rows);

    return saidas;
  }

  Future<List<SaidaModel>> _mapToModel(List<Map<String, dynamic>> rows) async {
    List<SaidaModel> saidas = [];
    for (Map<String, dynamic> row in rows) {
      Map<String, dynamic> data = row.map((key, value) => MapEntry(key, value));

      data['categorias'] = await _getCategorias(data['id']);
      SaidaModel saidaModel = SaidaModel.fromJson(data);

      if (data['cartao_credito'] != null) {
        saidaModel.cartaoCredito = await _getCartaoCredito(data['cartao_credito']);
      }

      saidas.add(saidaModel);
    }

    return saidas;
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

  Future<MessageType> saveCategoria(int idCategoria, int idSaida) async {
    int idInserido = await database.insert(
      table: 'saida_possui_categoria',
      data: {'id_saida': idSaida, 'id_categoria': idCategoria},
    );

    return MessageType(level: MessageLevel.success, message: 'Categoria salva', data: {'id': idInserido});
  }

  @override
  DBHelper get database => _dbHelper;

  @override
  String get table => 'saida';

  Future<List<Map<String, dynamic>>> _getCategorias(int idSaida) async {
    List<Map<String, dynamic>> categorias = await database.getData(
      columns: ['categoria.*'],
      table: 'saida_possui_categoria, categoria',
      where: 'saida_possui_categoria.id_categoria = categoria.id AND id_saida = ?',
      whereArgs: [idSaida],
    );

    return categorias;
  }

  Future<CartaoCreditoModel> _getCartaoCredito(int idCartao) async {
    return await _cartaoCreditoConnection.get(idCartao);
  }
}

final $SaidaConnection = BindInject((i) => SaidaConnection(i.get(), i.get()));
