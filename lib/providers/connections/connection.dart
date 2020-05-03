import 'package:controlegastos/models/model.dart';
import 'package:controlegastos/models/saida.dart';
import 'package:meta/meta.dart';

abstract class Connection {
  Future save(Model model) async {
    if (model.id == null) {
      return inserir(model);
    } else {
      return atualizar(model);
    }
  }

  Future<Map> inserir(@checked Model model);
  Future<Map> atualizar(@checked Model model);
  Future<Map> delete(@checked Model model);
}
