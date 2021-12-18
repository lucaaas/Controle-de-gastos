import 'package:controlegastos/app/modules/entrada/new_entrada_controller.dart';
import 'package:controlegastos/app/modules/entrada/new_entrada_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewEntradaModule extends Module {
  static const String URL = '/new-entrada';

  @override
  final List<Bind> binds = [
    $NewEntradaController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const NewEntradaPage()),
  ];
}

final $NewEntradaController = BindInject(
      (i) => NewEntradaController(i.get(), i.get(), i.get()),
  isSingleton: false,
);
