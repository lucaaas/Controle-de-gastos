import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/entrada.dart';
import 'package:controlegastos/app/core/models/model.dart';

import 'connection.dart';

class EntradaConnection extends Connection {
  final String tabela = 'entrada';

  @override
  Future<Mensagem> atualizar(Entrada entrada) async {
    try {
      int idEntrada = await DBHelper.update(
          tabela,
          {
            'descricao': entrada.descricao,
            'valor': entrada.valor,
            'data': entrada.data.toString(),
          },
          'id = ?',
          [entrada.id]);

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Entrada atualizada',
        id: idEntrada,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível atualizar nova entrada: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> inserir(Entrada entrada) async {
    try {
      int idEntrada = await DBHelper.insert(tabela, {
        'descricao': entrada.descricao,
        'valor': entrada.valor,
        'data': entrada.data.toString(),
      });

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Nova entrada inserida',
        id: idEntrada,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível criar nova entrada: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> delete(Entrada entrada) async {
    try {
      int idEntrada = await DBHelper.delete(tabela, 'id = ?', [entrada.id]);

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Entrada deletada',
        id: idEntrada,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível deletar entrada: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Model> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Model>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
