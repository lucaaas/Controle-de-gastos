import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/model.dart';
import 'package:controlegastos/app/core/models/saida.dart';
import 'package:controlegastos/app/core/providers/connections/connection.dart';


class SaidaConnection extends Connection {
  final String tabela = 'saida';

  @override
  Future<Mensagem> atualizar(Saida saida) async {
    try {
      int idSaida = await DBHelper.update(
          tabela,
          {
            'descricao': saida.descricao,
            'valor': saida.valor,
            'data': saida.data.toString(),
            'cartao_credito': saida.cartaoCredito!.id,
          },
          'id = ?',
          [saida.id]);

      final mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Saída atualizada',
        id: idSaida,
      );

      return mensagem;
    } catch (e) {
      final mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível atualizar nova saída: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> inserir(Saida saida) async {
    try {
      int idSaida = await DBHelper.insert(tabela, {
        'descricao': saida.descricao,
        'valor': saida.valor,
        'data': saida.data.toString(),
        'cartao_credito': saida.cartaoCredito!.id,
      });

      final mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Nova saída inserida',
        id: idSaida,
      );

      return mensagem;
    } catch (e) {
      final mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível criar nova saída: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> delete(Saida saida) async {
    try {
      int idSaida = await DBHelper.delete(tabela, 'id = ?', [saida.id]);

      final mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Saída deletada',
        id: idSaida,
      );

      return mensagem;
    } catch (e) {
      final mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível deletar saída: $e',
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
