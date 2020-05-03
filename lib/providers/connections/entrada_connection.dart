import 'package:controlegastos/helpers/db_helper.dart';
import 'package:controlegastos/models/entrada.dart';
import 'package:controlegastos/providers/connections/connection.dart';

class EntradaConnection extends Connection {
  final String tabela = 'entrada';

  @override
  Future<Map> atualizar(Entrada entrada) async {
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

      final resultado = {
        'tipo': 'info',
        'message': 'Entrada atualizada',
        'id': idEntrada
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível atualizar nova entrada: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> inserir(Entrada entrada) async {
    try {
      int idEntrada = await DBHelper.insert(tabela, {
        'descricao': entrada.descricao,
        'valor': entrada.valor,
        'data': entrada.data.toString(),
        'cartao_credito': entrada.cartaoCredito.id,
      });

      final resultado = {
        'tipo': 'info',
        'message': 'Nova entrada inserida',
        'id': idEntrada
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível criar nova entrada: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> delete(Entrada entrada) async {
    try {
      int idEntrada = await DBHelper.delete(tabela, 'id = ?', [entrada.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Entrada deletada',
        'id': idEntrada
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível deletar entrada: $e',
      };

      return resultado;
    }
  }
}
