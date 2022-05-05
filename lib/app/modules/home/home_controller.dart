import 'package:controlegastos/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeController {
  HomeController() {
    _init();
  }

  void _init() {}

  Future<void> refresh() async {
    Modular.to.popAndPushNamed(HomeModule.URL, forRoot: true);
  }
}
