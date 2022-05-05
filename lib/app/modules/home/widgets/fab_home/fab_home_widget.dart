import 'package:controlegastos/app/core/widgets/buttons/expandable_fab/expandable_fab_widget.dart';
import 'package:controlegastos/app/modules/entrada/new_entrada_module.dart';
import 'package:controlegastos/app/modules/saida/saida_form_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FabHomeWidget extends StatelessWidget {
  final void Function(String) goToRegister;

  const FabHomeWidget({required this.goToRegister, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFabWidget(
      distance: 80,
      children: [
        ActionButtonWidget(
          label: 'Entrada',
          onPressed: () => goToRegister('entrada'),
          icon: const Icon(Icons.attach_money),
        ),
        ActionButtonWidget(
          label: 'Saída',
          onPressed: () => goToRegister('saida'),
          icon: const Icon(Icons.money_off),
        ),
      ],
    );
  }
}
