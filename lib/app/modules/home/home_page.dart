import 'package:controlegastos/app/modules/home/home_controller.dart';
import 'package:controlegastos/app/modules/home/widgets/balances/credit_card_balance/credit_card_balance_widget.dart';
import 'package:controlegastos/app/modules/home/widgets/balances/month_balance/month_balance_widget.dart';
import 'package:controlegastos/app/modules/home/widgets/fab_home/fab_home_widget.dart';
import 'package:controlegastos/app/modules/home/widgets/last_transactions/last_transactions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Modular.get<HomeController>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _controller.refresh,
        child: ListView(
          children: const [
            MonthBalanceWidget(),
            CreditCardBalanceWidget(),
            LastTransactionsWidget(),
          ],
        ),
      ),
      floatingActionButton: FabHomeWidget(goToRegister: _controller.goToRegister),
    );
  }
}
