import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito.dart';
import 'package:controlegastos/app/core/models/model.dart';

import 'connection.dart';

class CartaoCreditoConnection extends Connection {
  final String tabela = 'entrada';

  @override
  Future<Mensagem> atualizar(CartaoCredito cartaoCredito) async {
    try {
      int idCartaoCredito = await DBHelper.update(
          tabela,
          {
            'nome': cartaoCredito.nome,
            'valor': cartaoCredito.cor,
          },
          'id = ?',
          [cartaoCredito.id]);

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Cartão de crédito atualizado',
        id: idCartaoCredito,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível atualizar cartão de crédito: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> inserir(CartaoCredito cartaoCredito) async {
    try {
      int idCartaoCredito = await DBHelper.insert(tabela, {
        'nome': cartaoCredito.nome,
        'valor': cartaoCredito.cor,
      });

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Novo cartão de crédito inserido',
        id: idCartaoCredito,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível criar novo cartão de crédito: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> delete(CartaoCredito cartaoCredito) async {
    try {
      int idCartaoCredito =
          await DBHelper.delete(tabela, 'id = ?', [cartaoCredito.id]);

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Cartão de crédito deletado',
        id: idCartaoCredito,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível deletar cartão de crédito: $e',
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
