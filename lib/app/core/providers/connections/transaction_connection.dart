import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/providers/connections/baseconnector.dart';
import 'package:controlegastos/app/core/types/message_type.dart';

abstract class TransactionConnection extends BaseConnector {
  @override
  Future<TransactionModel> get(int id) async {
    try {
      Map<String, dynamic> data = await database.getDataById(table: table, id: id);
      return await rowToModel(data);
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
  Future<List<TransactionModel>> getAll() async {
    try {
      List<Map<String, dynamic>> rows = await database.getData(table: table);

      List<TransactionModel> data = [];
      for (Map<String, dynamic> row in rows) {
        data.add(await rowToModel(row));
      }

      return data;
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

  Future<List<TransactionModel>> getAllEffectived(String month) async {
    List<Map<String, dynamic>> rows = await database.getData(
      table: table,
      where: 'data is NOT NULL AND data LIKE "$month%"',
      orderBy: 'data desc',
    );

    List<TransactionModel> transactions = await rowsToModels(rows);

    return transactions;
  }

  Future<double> getAvailableBalance() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> result = await database.getData(
      table: table,
      columns: ['SUM(valor) AS total'],
      where: 'data BETWEEN ? AND ?',
      whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
    );

    return result[0]['total'] ?? 0.0;
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

  Future<List<TransactionModel>> getLasts() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> rows = await database.getData(
        table: table,
        where: 'data BETWEEN ? AND ?',
        whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
        limit: 3,
        orderBy: 'data desc');

    List<TransactionModel> transactions = await rowsToModels(rows);

    return transactions;
  }

  Future<List<String>> getTransactionsMonths() async {
    String filter = 'substr(data, 0, 8)';
    List<Map<String, dynamic>> rows = await database.getData(
      table: table,
      columns: ['$filter as month'],
      groupBy: filter,
      orderBy: filter,
    );

    List<String> months = [];
    for (Map<String, dynamic> row in rows) {
      List<String> monthYear = row['month'].split('-');

      months.add('${monthYear[1]}/${monthYear[0]}');
    }

    return months;
  }

  Future<List<Map<String, dynamic>>> getCategorias(int idTransaction) async {
    List<Map<String, dynamic>> categorias = await database.getData(
      columns: ['categoria.*'],
      table: '$tableCategoriaTransaction, categoria',
      where: '$tableCategoriaTransaction.id_categoria = categoria.id AND id_transaction = ?',
      whereArgs: [idTransaction],
    );

    return categorias;
  }

  @override
  Future<MessageType> insert(TransactionModel model) async {
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

  Future<List<TransactionModel>> rowsToModels(List<Map<String, dynamic>> rows) async {
    List<TransactionModel> transactions = [];
    for (Map<String, dynamic> row in rows) {
      TransactionModel transactionModel = await rowToModel(row);
      transactions.add(transactionModel);
    }

    return transactions;
  }

  Future<MessageType> saveCategoria(int idCategoria, int idTransaction) async {
    int idInserido = await database.insert(
      table: tableCategoriaTransaction,
      data: {'id_transaction': idTransaction, 'id_categoria': idCategoria},
    );

    return MessageType(level: MessageLevel.success, message: 'Categoria salva', data: {'id': idInserido});
  }

  @override
  DBHelper get database;

  @override
  String get table;

  String get tableCategoriaTransaction;

  Future<TransactionModel> rowToModel(Map<String, dynamic> row);
}
