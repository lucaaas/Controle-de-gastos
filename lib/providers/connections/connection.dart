import 'package:controlegastos/models/model.dart';

abstract class Connection {
  Future save(Model model) async {
    if (model.id == null) {
      return inserir(model);
    } else {
      return atualizar(model);
    }
  }

  Future<Mensagem> inserir(covariant Model model);

  Future<Mensagem> atualizar(covariant Model model);

  Future<Mensagem> delete(covariant Model model);

  Future<Model> get(int id);

  Future<List<Model>> getAll();
}

class Mensagem {
  int _id;
  String _tipo;
  String _mensagem;

  Mensagem({int id, String tipo, String mensagem})
      : _id = id,
        _tipo = tipo,
        _mensagem = mensagem;

  int get id => _id;

  String get tipo => _tipo;

  String get mensagem => _mensagem;
}
