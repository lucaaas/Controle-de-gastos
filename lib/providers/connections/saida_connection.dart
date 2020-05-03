import 'package:controlegastos/helpers/db_helper.dart';
import 'package:controlegastos/models/saida.dart';
import 'package:controlegastos/providers/connections/connection.dart';

class SaidaConnection extends Connection {
  final String tabela = 'saida';

  @override
  Future<Map> atualizar(Saida saida) async {
    try {
      int idSaida = await DBHelper.update(
          tabela,
          {
            'descricao': saida.descricao,
            'valor': saida.valor,
            'data': saida.data.toString(),
            'cartao_credito': saida.cartaoCredito.id,
          },
          'id = ?',
          [saida.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Saída atualizada',
        'id': idSaida
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível atualizar nova saída: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> inserir(Saida saida) async {
    try {
      int idSaida = await DBHelper.insert(tabela, {
        'descricao': saida.descricao,
        'valor': saida.valor,
        'data': saida.data.toString(),
        'cartao_credito': saida.cartaoCredito.id,
      });

      final resultado = {
        'tipo': 'info',
        'message': 'Nova saída inserida',
        'id': idSaida
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível criar nova saída: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> delete(Saida saida) async {
    try {
      int idSaida = await DBHelper.delete(tabela, 'id = ?', [saida.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Saída deletada',
        'id': idSaida
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível deletar saída: $e',
      };

      return resultado;
    }
  }
}
