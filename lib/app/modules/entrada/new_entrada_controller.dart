import 'package:controlegastos/app/core/helpers/toast_helper.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:controlegastos/app/modules/tabs/tabs_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewEntradaController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final List<CategoriaModel> categorias = [];
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController data = TextEditingController();

  final EntradaConnection _entradaConnection;

  NewEntradaController(this._entradaConnection);

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

      Modular.to.pushReplacementNamed(TabsModule.URL);
    } catch (e) {
      MessageType message = e as MessageType;
      ToastHelper.show(key.currentContext!, message.message);
    }
  }
}
