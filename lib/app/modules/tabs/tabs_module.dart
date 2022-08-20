import 'package:controlegastos/app/modules/entrada/new_entrada_module.dart';
import 'package:controlegastos/app/modules/home/home_module.dart';
import 'package:controlegastos/app/modules/tabs/tabs_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TabsModule extends Module {
  static const String URL = '/tabs';

  @override
  final List<Bind> binds = [
    $HomeController,
    $NewEntradaController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const TabsPage()),
  ];
}
