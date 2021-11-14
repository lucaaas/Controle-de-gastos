import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

@Injectable(singleton: false)
class AppConfigModel {
  // colors
  final ColorScheme colorScheme = const ColorScheme(
    primary: Colors.purple,
    onPrimary: Colors.orangeAccent,
    secondary: Colors.orangeAccent,
    onSecondary: Colors.purple,
    background: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.purple,
    onSurface: Colors.orangeAccent,
    primaryVariant: Colors.deepPurple,
    secondaryVariant: Colors.deepOrange,
    brightness: Brightness.light,
  );

  // measures
  final EdgeInsetsGeometry margin = const EdgeInsets.all(20.0);

  // text
  final TextTheme textTheme = const TextTheme(
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  // stuff
  final VisualDensity visualDensity = VisualDensity.adaptivePlatformDensity;
}

final $AppConfigModel = BindInject((i) => AppConfigModel(), isSingleton: false);
