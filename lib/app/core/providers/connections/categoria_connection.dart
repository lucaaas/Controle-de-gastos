import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/categoria.dart';
import 'package:controlegastos/app/core/models/model.dart';

import 'connection.dart';

class CategoriaConnection extends Connection {
  final String tabela = 'entrada';

  @override
  Future<Mensagem> atualizar(Categoria categoria) async {
    try {
      int idCategoria = await DBHelper.update(
          tabela,
          {
            'nome': categoria.nome,
            'cor': categoria.cor,
            'descricao': categoria.descricao
          },
          'id = ?',
          [categoria.id]);

      final Mensagem mensagem = new Mensagem(
          tipo: 'info', mensagem: 'Categoria atualizada', id: idCategoria);

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível atualizar categoria: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> inserir(Categoria categoria) async {
    try {
      int idCategoria = await DBHelper.insert(tabela, {
        'nome': categoria.nome,
        'cor': categoria.cor,
        'descricao': categoria.descricao
      });

      final Mensagem mensagem = new Mensagem(
          tipo: 'info', mensagem: 'Nova categoria inserida', id: idCategoria);

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível criar nova categoria: $e',
      );

      return mensagem;
    }
  }

  @override
  Future<Mensagem> delete(Categoria categoria) async {
    try {
      int idCategoria = await DBHelper.delete(tabela, 'id = ?', [categoria.id]);

      final Mensagem mensagem = new Mensagem(
        tipo: 'info',
        mensagem: 'Categoria deletada',
        id: idCategoria,
      );

      return mensagem;
    } catch (e) {
      final Mensagem mensagem = new Mensagem(
        tipo: 'erro',
        mensagem: 'Não foi possível deletar categoria: $e',
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
