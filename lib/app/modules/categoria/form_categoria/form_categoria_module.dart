import 'package:controlegastos/app/modules/categoria/form_categoria/form_categoria_controller.dart';
import 'package:controlegastos/app/modules/categoria/form_categoria/form_categoria_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormCategoriaModule extends Module {
  static const String URL = '/form-categoria';

  @override
  final List<Bind> binds = [
    $FormCategoriaController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => FormCategoriaPage()),
  ];
}

final $FormCategoriaController = BindInject(
  (i) => FormCategoriaController(i.get()),
  isSingleton: false,
);
