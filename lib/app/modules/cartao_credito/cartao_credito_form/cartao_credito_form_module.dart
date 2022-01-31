import 'package:controlegastos/app/modules/cartao_credito/cartao_credito_form/cartao_credito_form_controller.dart';
import 'package:controlegastos/app/modules/cartao_credito/cartao_credito_form/cartao_credito_form_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CartaoCreditoFormModule extends Module {
  static const String URL = '/form-cartao-credito';

  @override
  final List<Bind> binds = [
    $CartaoCreditoFormController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CartaoCreditoFormPage()),
  ];
}

final $CartaoCreditoFormController = BindInject(
  (i) => CartaoCreditoFormController(i.get()),
  isSingleton: false,
);
