import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/basemodel.dart';

mixin BaseConnector {
  Future save(BaseModel model) async {
    if (model.id == null) {
      return insert(model);
    } else {
      return update(model);
    }
  }

  Future<Mensagem> insert();

  Future<Mensagem> update(covariant BaseModel model);

  Future<Mensagem> delete(covariant BaseModel model);

  Future<BaseModel> get(int id);

  Future<List<BaseModel>> getAll();

  String get table;

  DBHelper get database;
}

class Mensagem {
  int? _id;
  String? _tipo;
  String? _mensagem;

  Mensagem({int? id, String? tipo, String? mensagem})
      : _id = id,
        _tipo = tipo,
        _mensagem = mensagem;

  int? get id => _id;

  String? get tipo => _tipo;

  String? get mensagem => _mensagem;
}
