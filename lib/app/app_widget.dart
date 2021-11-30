import 'package:controlegastos/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Modular.get<AppController>();

    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorScheme: controller.appConfig.colorScheme ,
        // buttonTheme: ThemeData.from(colorScheme: _colorScheme, textTheme: TextTheme()),
        visualDensity: controller.appConfig.visualDensity,
      ),
    ).modular();
  }
}

