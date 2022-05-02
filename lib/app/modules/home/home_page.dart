import 'package:controlegastos/app/modules/home/home_controller.dart';
import 'package:controlegastos/app/modules/home/widgets/fab_home/fab_home_widget.dart';
import 'package:controlegastos/app/modules/home/widgets/saldo/saldo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Modular.get<HomeController>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _controller.real_balance,
            builder: (context, double value, child) => SaldoWidget(
              realValue: value,
              projectedValue: -10,
            ),
          ),
        ],
      ),
      floatingActionButton: const FabHomeWidget(),
    );
  }
}
