import 'package:controlegastos/app/app_controller.dart';
import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:controlegastos/app/core/providers/connections/cartao_credito_connection.dart';
import 'package:controlegastos/app/core/providers/connections/categoria_connection.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/modules/cartao_credito/cartao_credito_form/cartao_credito_form_module.dart';
import 'package:controlegastos/app/modules/cartao_credito/widgets/select_cartao_credito_controller.dart';
import 'package:controlegastos/app/modules/categoria/form_categoria/form_categoria_module.dart';
import 'package:controlegastos/app/modules/categoria_tag_select/categoria_tag_select_controller.dart';
import 'package:controlegastos/app/modules/saida/saida_form_module.dart';
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
    $SelectCartaoCreditoController,
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SaidaFormModule()),
    ModuleRoute(FormCategoriaModule.URL, module: FormCategoriaModule()),
    ModuleRoute(SaidaFormModule.URL, module: SaidaFormModule()),
    ModuleRoute(CartaoCreditoFormModule.URL, module: CartaoCreditoFormModule()),
  ];
}

final $AppController = BindInject((i) => AppController(i.get()));
