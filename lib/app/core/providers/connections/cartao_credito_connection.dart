import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/types/MessageType.dart';

import 'baseconnector.dart';

class CartaoCreditoConnection extends BaseConnector {
  DBHelper _dbHelper;

  CartaoCreditoConnection(this._dbHelper);

  @override
  Future<CartaoCreditoModel> get(int id) async {
    try {
      Map<String, dynamic> data =
          await database.getDataById(table: table, id: id);
      return CartaoCreditoModel.fromJson(data);
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.ERROR,
          message: 'Não foi possível recuperar registro de $table: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  @override
  Future<List<CartaoCreditoModel>> getAll() async {
    try {
      List<Map<String, dynamic>> rows = await database.getData(table: table);

      List<CartaoCreditoModel> data = [];
      for (Map<String, dynamic> row in rows) {
        data.add(CartaoCreditoModel.fromJson(row));
      }

      return data;
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.ERROR,
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
}
