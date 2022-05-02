import 'package:controlegastos/app/modules/home/home_controller.dart';
import 'package:controlegastos/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  static const String URL = '/home';

  @override
  final List<Bind> binds = [
    $HomeController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage()),
  ];
}

final $HomeController = BindInject(
  (i) => HomeController(i.get(), i.get()),
  isSingleton: false,
);
