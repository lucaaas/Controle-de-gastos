import 'package:controlegastos/app/core/widgets/buttons/expandable_fab/expandable_fab_widget.dart';
import 'package:controlegastos/app/modules/entrada/new_entrada_module.dart';
import 'package:controlegastos/app/modules/saida/saida_form_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FabHomeWidget extends StatelessWidget {
  const FabHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFabWidget(
      distance: 80,
      children: [
        ActionButtonWidget(
          label: 'Entrada',
          onPressed: () => _goToRegister('entrada'),
          icon: const Icon(Icons.attach_money),
        ),
        ActionButtonWidget(
          label: 'Saída',
          onPressed: () => _goToRegister('saida'),
          icon: const Icon(Icons.money_off),
        ),
      ],
    );
  }

  void _goToRegister(String type) {
    switch (type) {
      case 'entrada':
        Modular.to.pushNamed(NewEntradaModule.URL);
        break;
      case 'saida':
        Modular.to.pushNamed(SaidaFormModule.URL);
    }
  }
}
