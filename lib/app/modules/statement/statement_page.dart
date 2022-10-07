import 'dart:core';

import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/modules/statement/statement_controller.dart';
import 'package:controlegastos/app/modules/statement/widgets/transaction_list/transaction_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({Key? key}) : super(key: key);

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  final StatementController _controller = Modular.get<StatementController>();
  List<String> _months = [];
  List<TransactionListWidget> _transactionPages = [];

  @override
  void initState() {
    _getMonthsAndLastTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _months.length,
      child: Scaffold(
        appBar: TabBar(
          tabs: _generateTabs(),
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).colorScheme.primary,
        ),
        body: TabBarView(
          children: _transactionPages,
        ),
      ),
    );
  }

  List<Tab> _generateTabs() {
    List<Tab> tabs = [];
    for (String month in _months) {
      tabs.add(
        Tab(
          child: Text(month),
        ),
      );
    }

    return tabs;
  }

  void _getMonthsAndLastTransactions() async {
    List<String> months = await _controller.getMonths();
    List<TransactionListWidget> pages = await _mountPages(months);

    setState(() {
      _months = months;
      _transactionPages = pages;
    });
  }

  Future<List<TransactionListWidget>> _mountPages(List<String> months) async {
    List<TransactionListWidget> pages = [];

    for (String month in months) {
      List<TransactionModel> transactions = await _controller.getTransactions(month);
      pages.add(TransactionListWidget(transactions: transactions));
    }

    return pages;
  }
}
