import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'baseconnector.dart';

class EntradaConnection extends BaseConnector {
  final DBHelper _dbHelper;

  EntradaConnection(this._dbHelper);

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
}

final $EntradaConnection = BindInject((i) => EntradaConnection(i.get()));