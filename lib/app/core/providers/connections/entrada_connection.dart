import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/providers/connections/transaction_connection.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EntradaConnection extends TransactionConnection {
  final DBHelper _dbHelper;

  EntradaConnection(
    this._dbHelper,
  );

  @override
  Future<EntradaModel> rowToModel(Map<String, dynamic> row) async {
    Map<String, dynamic> data = row.map((key, value) => MapEntry(key, value));

    data['categorias'] = await getCategorias(data['id']);
    return EntradaModel.fromJson(data);
  }

  @override
  DBHelper get database => _dbHelper;

  @override
  String get table => 'entrada';

  @override
  String get tableCategoriaTransaction => 'entrada_possui_categoria';
}

final $EntradaConnection = BindInject((i) => EntradaConnection(i.get()));
