import 'package:controlegastos/app/modules/home/widgets/saldo_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      body: Column(
        children: const [
          SaldoWidget(
            realValue: 120,
            projectedValue: -10,
          ),
        ],
      ),
    );
  }
}
