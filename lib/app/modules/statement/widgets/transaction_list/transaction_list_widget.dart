import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/widgets/card/card_widget.dart';
import 'package:controlegastos/app/modules/statement/widgets/transaction_list/widgets/transaction/transaction_widget.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatefulWidget {
  final List<TransactionModel> transactions;

  const TransactionListWidget({Key? key, required this.transactions}) : super(key: key);

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  List<TransactionWidget> _transctions = [];
  double sumEntrada = 0.0;
  double sumSaida = 0.0;

  @override
  void initState() {
    super.initState();
    getTilesTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          children: [
            CardWidget(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Entradas: R\$ $sumEntrada',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Saídas: R\$ $sumSaida',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Saldo: R\$ ${sumEntrada - sumSaida}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ..._transctions,
          ],
        ),
      ),
    );
  }

  void getTilesTransactions() async {
    List<TransactionWidget> transactionWidgets = [];
    double sumEntrada = 0.0;
    double sumSaida = 0.0;

    for (TransactionModel transaction in widget.transactions) {
      if (transaction.runtimeType == EntradaModel) {
        sumEntrada += transaction.valor;
      } else {
        sumSaida += transaction.valor;
      }

      transactionWidgets.add(TransactionWidget(transaction: transaction));
    }

    setState(() {
      _transctions = transactionWidgets;
      this.sumEntrada = sumEntrada;
      this.sumSaida = sumSaida;
    });
  }
}
