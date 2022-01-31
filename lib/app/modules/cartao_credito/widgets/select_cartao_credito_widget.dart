import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/widgets/select_field/select_field_widget.dart';
import 'package:controlegastos/app/modules/cartao_credito/widgets/select_cartao_credito_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectCartaoCreditoWidget extends StatelessWidget {
  final SelectCartaoCreditoController _controller = Modular.get<SelectCartaoCreditoController>();

  SelectCartaoCreditoWidget({Key? key, required void Function(CartaoCreditoModel) onSelect}) : super(key: key) {
    _controller.onSelect = onSelect;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller.options,
      builder: (context, List<OptionSelectWidget<CartaoCreditoModel>> options, child) {
        return SelectFieldWidget<CartaoCreditoModel>(
          label: 'Cartão de crédito',
          icon: const Icon(Icons.credit_card),
          options: options,
          createItem: () => _controller.createCartao(),
          onSelect: _controller.onSelect,
        );
      },
    );
  }
}
