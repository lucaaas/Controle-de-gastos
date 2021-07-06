import 'package:controlegastos/app/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppController controller = Modular.get<AppController>();

    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: controller.appConfig.primaryColor,
        accentColor: controller.appConfig.accentColor,
        visualDensity: controller.appConfig.visualDensity,
        textTheme: controller.appConfig.textTheme,
      ),
    ).modular();
  }
}
