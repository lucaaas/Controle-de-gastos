import 'package:controlegastos/app/modules/statement/statement_controller.dart';
import 'package:controlegastos/app/modules/statement/statement_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StatementModule extends Module {
  static String URL = '/statement';

  @override
  final List<Bind> binds = [
    $StatementController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const StatementPage()),
  ];
}

final $StatementController = BindInject(
  (i) => StatementController(
    i.get(),
    i.get(),
  ),
  isSingleton: false,
);
