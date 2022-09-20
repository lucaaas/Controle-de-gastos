import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/modules/statement/statement_controller.dart';
import 'package:controlegastos/app/modules/statement/widgets/transaction/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({Key? key}) : super(key: key);

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  final StatementController _controller = Modular.get<StatementController>();
  List<TransactionWidget> _transctions = [];

  @override
  void initState() {
    super.initState();
    getTilesTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _transctions,
      ),
    );
  }

  void getTilesTransactions() async {
    List<TransactionModel> transactions = await _controller.getTransactions();

    List<TransactionWidget> transactionWidgets = [];
    for (TransactionModel transaction in transactions) {
      transactionWidgets.add(TransactionWidget(transaction: transaction));
    }

    setState(() {
      _transctions = transactionWidgets;
    });
  }
}
