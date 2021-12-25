import 'dart:async';

import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/widgets/tag_selectize/tag_selectize_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriaTagSelectController {
  late List<CategoriaModel> categorias = [];
  final CategoriaConnection _categoriaConnection;

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
    if (text.length >= 3) {
      List<CategoriaModel> categoriaSuggestions = await _categoriaConnection.getAllByContainsNome(text);
      return categoriaSuggestions;
    } else {
      return [];
    }
  }
}

final $CategoriaTagSelectController = BindInject(
  (i) => CategoriaTagSelectController(i.get()),
  isSingleton: false,
);
