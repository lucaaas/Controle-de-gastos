import 'dart:async';

import 'package:controlegastos/app/core/helpers/toast_helper.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter/material.dart';

class NewEntradaController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final List<CategoriaModel> categorias = [];
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController data = TextEditingController();

  final CategoriaConnection _categoriaConnection;
  final EntradaConnection _entradaConnection;

  NewEntradaController(this._categoriaConnection, this._entradaConnection);

  Future<void> openDatePicker(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      data.text = dataSelecionada.toString().split(' ')[0];
    } else {
      data.text = '';
    }
  }

  void save() async {
    try {
      DateTime? dataEntrada = data.text.isNotEmpty ? DateTime.parse(data.text) : null;

      EntradaModel entrada = EntradaModel(
        descricao: descricao.text,
        valor: double.parse(valor.text.replaceAll('R\$', '').replaceAll(' ', '')),
        data: dataEntrada,
        categorias: categorias.toList(),
      );

      MessageType message = await _entradaConnection.save(entrada);
      ToastHelper.show(key.currentContext!, message.message);
    } catch (e) {
      MessageType message = e as MessageType;
      ToastHelper.show(key.currentContext!, message.message);
    }
  }

  // TODO remover
  void insertCategoria() async {
    await _categoriaConnection.insert(CategoriaModel(nome: 'Salário'));
    await _categoriaConnection.insert(CategoriaModel(nome: 'Freela'));

    await _entradaConnection.insert(EntradaModel(descricao: 'Uma entrada', valor: 120));
  }
}
