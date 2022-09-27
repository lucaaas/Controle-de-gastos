import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/modules/statement/widgets/transaction_list/widgets/transaction/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TransactionListWidget extends StatefulWidget {
  final List<TransactionModel> transactions;

  const TransactionListWidget({Key? key, required this.transactions}) : super(key: key);

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
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
    List<TransactionWidget> transactionWidgets = [];
    for (TransactionModel transaction in widget.transactions) {
      transactionWidgets.add(TransactionWidget(transaction: transaction));
    }

    setState(() {
      _transctions = transactionWidgets;
    });
  }
}