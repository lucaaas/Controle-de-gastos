import 'package:controlegastos/app/modules/saida/saida_form_controller.dart';
import 'package:controlegastos/app/modules/saida/saida_form_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaidaFormModule extends Module {
  static const String URL = '/form-saida';

  @override
  final List<Bind> binds = [
    $SaidaFormController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SaidaFormPage()),
  ];
}

final $SaidaFormController = BindInject(
  (i) => SaidaFormController(i.get()),
  isSingleton: false,
);
