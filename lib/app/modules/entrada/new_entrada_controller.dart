import 'dart:async';

import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:controlegastos/app/core/models/categoria.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';

class NewEntradaController {
  final AppConfigModel appConfigModel;

  final List<Categoria> categorias = [];
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController data = TextEditingController();

  final CategoriaConnection _categoriaConnection;

  NewEntradaController(this.appConfigModel, this._categoriaConnection);

  Future<void> openDatePicker(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      data.text = '${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}';
    } else {
      data.text = '';
    }
  }

  Widget itemBuilder(BuildContext context, Categoria categoria) {
    return ListTile(
      title: Text(categoria.nome),
      subtitle: Text(categoria.descricao),
      leading: Icon(Icons.add),
    );
  }

  TagWidget buildTag(Categoria categoria) {
    return TagWidget(
      text: categoria.nome,
      color: Color(categoria.cor),
      onDeleted: () => categorias.remove(categoria),
    );
  }

  FutureOr<Iterable<Categoria>> suggestionsCallback(String text) async {
    throw UnimplementedError();
    // return _categoriaConnection.
  }
}
