import 'dart:async';

import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/widgets/tag_selectize/tag_selectize_widget.dart';
import 'package:controlegastos/app/modules/categoria/form_categoria/form_categoria_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriaTagSelectController {
  ValueNotifier<List<CategoriaModel>> categorias = ValueNotifier([]);
  final CategoriaConnection _categoriaConnection;
  late final GlobalKey key;

  CategoriaTagSelectController(this._categoriaConnection);

  Widget itemBuilder(BuildContext context, CategoriaModel categoria) {
    return ListTile(
      title: Text(categoria.nome),
      subtitle: Text(categoria.descricao ?? ''),
      leading: const Icon(Icons.add),
    );
  }

  InfoTag getInfoTags(CategoriaModel categoria) {
    return InfoTag(label: categoria.nome, color: categoria.cor);
  }

  FutureOr<Iterable<CategoriaModel>> suggestionsCallback(String text) async {
    List<CategoriaModel> categoriaSuggestions = await _categoriaConnection.getAllByContainsNome(text);
    return categoriaSuggestions;
  }

  Widget noItemsFoundBuilder(BuildContext context) {
    return ListTile(
      title: const Text('Criar categoria'),
      leading: const Icon(Icons.add),
      onTap: _createCategoria,
    );
  }

  void _createCategoria() async {
    CategoriaModel? categoria = await Modular.to.pushNamed<CategoriaModel>(FormCategoriaModule.URL);
    if (categoria != null) {
      categorias.value = List.from(categorias.value)..add(categoria);
    }
  }
}

final $CategoriaTagSelectController = BindInject(
  (i) => CategoriaTagSelectController(i.get()),
  isSingleton: false,
);
