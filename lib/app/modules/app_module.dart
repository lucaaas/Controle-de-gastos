import 'package:controlegastos/app/app_controller.dart';
import 'package:controlegastos/app/app_widget.dart';
import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    $AppConfigModel,
  ];

  Widget get bootstrap => const AppWidget();

  @override
  final List<ModularRoute> routes = [];
}

final $AppController = BindInject((i) => AppController(i.get()));