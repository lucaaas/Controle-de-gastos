import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'baseconnector.dart';

class EntradaConnection extends BaseConnector {
  final DBHelper _dbHelper;
  final CategoriaConnection _categoriaConnection;

  EntradaConnection(this._dbHelper, this._categoriaConnection);

  @override
  Future<EntradaModel> get(int id) async {
    try {
      Map<String, dynamic> data = await database.getDataById(table: table, id: id);
      data['categorias'] = _getCategorias(id);

      return EntradaModel.fromJson(data);
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
  Future<List<EntradaModel>> getAll() async {
    try {
      List<Map<String, dynamic>> rows = await database.getData(table: table);

      List<EntradaModel> data = [];
      for (Map<String, dynamic> row in rows) {
        row['categorias'] = await _getCategorias(row['id']);
        data.add(EntradaModel.fromJson(row));
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

  Future<List<EntradaModel>> getAllEffectived() async{
    List<Map<String, dynamic>> rows = await database.getData(
        table: table,
        where: 'data is NOT NULL',
        orderBy: 'data desc');

    List<EntradaModel> entradas = await _mapToModel(rows);

    return entradas;
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

  Future<List<EntradaModel>> getLasts() async {
    DateTime now = DateTime.now();

    List<Map<String, dynamic>> rows = await database.getData(
        table: table,
        where: 'data BETWEEN ? AND ?',
        whereArgs: [DateTime(now.year, now.month, 1).toString(), DateTime(now.year, now.month + 1, 0).toString()],
        limit: 3,
        orderBy: 'data desc');

    List<EntradaModel> entradas = await _mapToModel(rows);

    return entradas;
  }

  @override
  Future<MessageType> insert(EntradaModel model) async {
    try {
      MessageType messageInsert = await super.insert(model);
      if (messageInsert.level == MessageLevel.success) {
        for (CategoriaModel categoria in model.categorias ?? []) {
          saveCategoriaEntrada(categoria.id!, messageInsert.data!['id']);
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
  String get table => 'entrada';

  Future<List<Map<String, dynamic>>> _getCategorias(int idEntrada) async {
    return await database.getData(
      table: 'entrada_possui_categoria',
      where: 'id_entrada = ?',
      whereArgs: [idEntrada],
    );
  }

  Future<MessageType> saveCategoriaEntrada(int idCategoria, int idEntrada) async {
    int idInserido = await database.insert(
      table: 'entrada_possui_categoria',
      data: {'id_entrada': idEntrada, 'id_categoria': idCategoria},
    );

    return MessageType(level: MessageLevel.success, message: 'Categoria salva', data: {'id': idInserido});
  }

  Future<List<EntradaModel>> _mapToModel(List<Map<String, dynamic>> rows) async {
    List<EntradaModel> entradas = [];
    for (Map<String, dynamic> row in rows) {
      Map<String, dynamic> data = row.map((key, value) => MapEntry(key, value));

      data['categorias'] = await _getCategorias(data['id']);
      EntradaModel entradaModel = EntradaModel.fromJson(data);

      entradas.add(entradaModel);
    }

    return entradas;
  }
}

final $EntradaConnection = BindInject((i) => EntradaConnection(i.get(), i.get()));
