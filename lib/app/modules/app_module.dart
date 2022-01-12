import 'package:controlegastos/app/app_controller.dart';
import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/modules/categoria/form_categoria/form_categoria_module.dart';
import 'package:controlegastos/app/modules/categoria_tag_select/categoria_tag_select_controller.dart';
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
    $CategoriaTagSelectController,
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: NewEntradaModule()),
    ModuleRoute(FormCategoriaModule.URL, module: FormCategoriaModule()),
  ];
}

final $AppController = BindInject((i) => AppController(i.get()));
