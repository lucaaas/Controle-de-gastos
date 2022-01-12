import 'package:controlegastos/app/core/helpers/toast_helper.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormCategoriaController {
  final TextEditingController nome = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  Color? _color;

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final CategoriaConnection _connection;

  FormCategoriaController(this._connection);

  void onColorSelected(Color color) {
    _color = color;
  }

  void cancelar() {
    Modular.to.pop();
  }

  void save() {
    if (key.currentState!.validate()) {
      CategoriaModel categoria = CategoriaModel(nome: nome.text, descricao: descricao.text, cor: _color);
      try {
        _connection.save(categoria);
        Modular.to.pop(categoria);
      } catch (e) {
        MessageType message = e as MessageType;
        ToastHelper.show(key.currentContext!, message.message);
      }
    }
  }
}
