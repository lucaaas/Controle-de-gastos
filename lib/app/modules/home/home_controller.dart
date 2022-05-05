import 'package:controlegastos/app/modules/entrada/new_entrada_module.dart';
import 'package:controlegastos/app/modules/home/home_module.dart';
import 'package:controlegastos/app/modules/saida/saida_form_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeController {
  HomeController() {
    _init();
  }

  void _init() {}

  Future<void> refresh() async {
    Modular.to.popAndPushNamed(HomeModule.URL, forRoot: true);
  }

  void goToRegister(String type) async {
    switch (type) {
      case 'entrada':
        await Modular.to.pushNamed(NewEntradaModule.URL);
        break;
      case 'saida':
        await Modular.to.pushNamed(SaidaFormModule.URL);
    }

    refresh();
  }
}
