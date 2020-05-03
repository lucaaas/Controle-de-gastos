import 'package:controlegastos/helpers/db_helper.dart';
import 'package:controlegastos/models/categoria.dart';
import 'package:controlegastos/providers/connections/connection.dart';

class CategoriaConnection extends Connection {
  final String tabela = 'entrada';

  @override
  Future<Map> atualizar(Categoria categoria) async {
    try {
      int idCategoria = await DBHelper.update(
          tabela,
          {
            'nome': categoria.nome,
            'valor': categoria.cor,
            'descricao': categoria.descricao
          },
          'id = ?',
          [categoria.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Categoria atualizada',
        'id': idCategoria
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível atualizar categoria: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> inserir(Categoria categoria) async {
    try {
      int idCategoria = await DBHelper.insert(tabela, {
        'nome': categoria.nome,
        'valor': categoria.cor,
        'descricao': categoria.descricao
      });

      final resultado = {
        'tipo': 'info',
        'message': 'Nova categoria inserida',
        'id': idCategoria
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível criar nova categoria: $e',
      };

      return resultado;
    }
  }

  @override
  Future<Map> delete(Categoria categoria) async {
    try {
      int idCategoria = await DBHelper.delete(tabela, 'id = ?', [categoria.id]);

      final resultado = {
        'tipo': 'info',
        'message': 'Categoria deletada',
        'id': idCategoria
      };

      return resultado;
    } catch (e) {
      final resultado = {
        'tipo': 'erro',
        'message': 'Não foi possível deletar categoria: $e',
      };

      return resultado;
    }
  }
}
