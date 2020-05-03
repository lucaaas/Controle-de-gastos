import 'package:controlegastos/helpers/db_helper.dart';
import 'package:controlegastos/models/cartao_credito.dart';
import 'package:controlegastos/providers/connections/connection.dart';

class CartaoCreditoConnection extends Connection {
  final String tabela = 'entrada';

  @override
  Future<Map> atualizar(CartaoCredito cartaoCredito) async {
    try {
      int idCartaoCredito = await DBHelper.update(
          tabela,
          {
            'nome': cartaoCredito.nome,
            'valor': cartaoCredito.cor,
          },
          'id = ?',
          [cartaoCredito.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Cartão de crédito atualizado',
        'id': idCartaoCredito
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível atualizar cartão de crédito: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> inserir(CartaoCredito cartaoCredito) async {
    try {
      int idCartaoCredito = await DBHelper.insert(tabela, {
        'nome': cartaoCredito.nome,
        'valor': cartaoCredito.cor,
      });

      final resultado = {
        'tipo': 'info',
        'message': 'Novo cartão de crédito inserido',
        'id': idCartaoCredito
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível criar novo cartão de crédito: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> delete(CartaoCredito cartaoCredito) async {
    try {
      int idCartaoCredito = await DBHelper.delete(tabela, 'id = ?', [cartaoCredito.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Cartão de crédito deletado',
        'id': idCartaoCredito
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível deletar cartão de crédito: $e',
      };

      return resultado;
    }
  }
}
