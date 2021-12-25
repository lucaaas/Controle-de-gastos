import 'dart:async';

import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:flutter/material.dart';

class NewEntradaController {
  final AppConfigModel appConfigModel;

  final List<CategoriaModel> categorias = [];
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController data = TextEditingController();

  final CategoriaConnection _categoriaConnection;
  final EntradaConnection _entradaConnection;

  NewEntradaController(this.appConfigModel, this._categoriaConnection, this._entradaConnection);

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

  void save() {
    print(categorias);
  }

  // TODO remover
  void insertCategoria() async {
    await _categoriaConnection.insert(CategoriaModel(nome: 'Salário'));
    await _categoriaConnection.insert(CategoriaModel(nome: 'Freela'));

    await _entradaConnection.insert(EntradaModel(descricao: 'Uma entrada', valor: 120));
  }
}
