import 'package:controlegastos/app/core/helpers/toast_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CartaoCreditoFormController {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController nome = TextEditingController();
  Color? _color;
  final CartaoCreditoConnection _connection;

  CartaoCreditoFormController(this._connection);

  void onColorSelected(Color color) {
    _color = color;
  }

  void cancelar() {
    Modular.to.pop();
  }

  void save() {
    if (key.currentState!.validate()) {
      CartaoCreditoModel cartao = CartaoCreditoModel(nome: nome.text, cor: _color);
      try {
        _connection.save(cartao);
        Modular.to.pop(cartao);
      } catch (e) {
        MessageType message = e as MessageType;
        ToastHelper.show(key.currentContext!, message.message);
      }
    }
  }
}
