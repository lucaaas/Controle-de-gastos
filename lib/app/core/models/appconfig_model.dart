import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

@Injectable(singleton: false)
class AppConfigModel {
  // colors
  final MaterialColor primaryColor = Colors.deepPurple;
  final MaterialColor accentColor = Colors.orange;

  // measures
  final EdgeInsetsGeometry margin = EdgeInsets.all(20.0);

  // text
  final TextTheme textTheme = TextTheme(
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  // stuff
  final VisualDensity visualDensity = VisualDensity.adaptivePlatformDensity;
}

final $AppConfigModel = BindInject((i) => AppConfigModel(), isSingleton: false);
