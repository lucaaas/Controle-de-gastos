import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/models/saida_model.dart';
import 'package:controlegastos/app/core/providers/connections/baseconnector.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/types/MessageType.dart';

class SaidaConnection extends BaseConnector {
  DBHelper _dbHelper;
  CartaoCreditoConnection _cartaoCreditoConnection;

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
          level: MessageLevel.ERROR,
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

      List<SaidaModel> data = [];
      for (Map<String, dynamic> row in rows) {
        row['categorias'] = await _getCategorias(row['id']);
        SaidaModel saidaModel = SaidaModel.fromJson(row);

        if (row.containsKey('cartao_credito')) {
          saidaModel.cartaoCredito = await _getCartaoCredito(row['cartao_credito']);
        }

        data.add(saidaModel);
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

  Future<List<Map<String, dynamic>>> _getCategorias(int idSaida) async {
    return await database.getData(
      table: 'saida_possui_categoria',
      where: 'id_entrada = ?',
      whereArgs: [idSaida],
    );
  }

  Future<CartaoCreditoModel> _getCartaoCredito(int idCartao) async {
    return await _cartaoCreditoConnection.get(idCartao);
  }
}
