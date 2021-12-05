import 'package:controlegastos/app/app_controller.dart';
import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/modules/entrada/new_entrada_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    $AppConfigModel,
    $AppController,
    $CategoriaConnection,
    $CartaoCreditoConnection,
    $DBHelper,
    $EntradaConnection,
    $SaidaConnection,
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: NewEntradaModule()),
  ];
}

final $AppController = BindInject((i) => AppController(i.get()));
