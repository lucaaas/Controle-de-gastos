import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/widgets/select_field/select_field_widget.dart';
import 'package:controlegastos/app/modules/cartao_credito/cartao_credito_form/cartao_credito_form_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectCartaoCreditoController {
  final CartaoCreditoConnection _connection;

  late ValueNotifier<List<OptionSelectWidget<CartaoCreditoModel>>> options = ValueNotifier([]);
  late void Function(CartaoCreditoModel) onSelect;

  SelectCartaoCreditoController(this._connection) {
    _getCartoes();
  }

  Future<OptionSelectWidget<CartaoCreditoModel>?>? createCartao() async {
    CartaoCreditoModel? cartaoCredito = await Modular.to.pushNamed(CartaoCreditoFormModule.URL);
    if (cartaoCredito != null) {
      return OptionSelectWidget(label: cartaoCredito.nome, color: cartaoCredito.cor, value: cartaoCredito);
    } else {
      return null;
    }
  }

  void _getCartoes() async {
    try {
      List<CartaoCreditoModel> cartoes = await _connection.getAll();
      List<OptionSelectWidget<CartaoCreditoModel>> opcoes = [];
      for (CartaoCreditoModel cartao in cartoes) {
        opcoes.add(OptionSelectWidget(label: cartao.toString(), color: cartao.cor, value: cartao));
      }

      options.value = opcoes;
    } catch (e) {}
  }
}

final $SelectCartaoCreditoController = BindInject(
  (i) => SelectCartaoCreditoController(i.get()),
  isSingleton: false,
);
