import 'package:controlegastos/app/core/helpers/toast_helper.dart';
import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/saida_model.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/core/types/message_type.dart';
import 'package:controlegastos/app/modules/tabs/tabs_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaidaFormController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  CartaoCreditoModel? cartaoCredito;
  final List<CategoriaModel> categorias = [];
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController data = TextEditingController();
  final TextEditingController repeticao = TextEditingController();

  final SaidaConnection _connection;

  SaidaFormController(this._connection);

  void onSelectCartao(CartaoCreditoModel cartaoSelecionado) {
    cartaoCredito = cartaoSelecionado;
  }

  void save() async {
    try {
      DateTime? dataSaida = DateTime.tryParse(data.text);

      SaidaModel saida = SaidaModel(
        descricao: descricao.text,
        valor: double.parse(valor.text.replaceAll('R\$', '').replaceAll(' ', '')),
        data: dataSaida,
        categorias: categorias.toList(),
        cartaoCredito: cartaoCredito,
      );

      MessageType message = await _connection.save(saida);
      ToastHelper.show(key.currentContext!, message.message);

      Modular.to.pushReplacementNamed(TabsModule.URL);
    } catch (e) {
      MessageType message = e as MessageType;
      ToastHelper.show(key.currentContext!, message.message);
    }
  }
}