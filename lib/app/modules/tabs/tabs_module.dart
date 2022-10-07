import 'package:controlegastos/app/modules/home/home_module.dart';
import 'package:controlegastos/app/modules/statement/statement_module.dart';
import 'package:controlegastos/app/modules/tabs/tabs_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TabsModule extends Module {
  static const String URL = '/tabs';

  @override
  final List<Bind> binds = [
    $HomeController,
    $StatementController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const TabsPage()),
  ];
}
