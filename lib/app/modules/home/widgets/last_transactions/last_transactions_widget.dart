import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/models/saida_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/core/widgets/card/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LastTransactionsWidget extends StatefulWidget {
  const LastTransactionsWidget({Key? key}) : super(key: key);

  @override
  State<LastTransactionsWidget> createState() => _LastTransactionsWidgetState();
}

class _LastTransactionsWidgetState extends State<LastTransactionsWidget> {
  final SaidaConnection _saidaConnection = Modular.get<SaidaConnection>();
  final EntradaConnection _entradaConnection = Modular.get<EntradaConnection>();

  late List<TransactionModel> saidas;
  late List<TransactionModel> entradas;

  @override
  void initState() {
    saidas = [];
    entradas = [];
    _getLastTransactions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardWidget(
          leadingIcon: const Icon(Icons.arrow_upward),
          title: 'Últimas saídas',
          body: Column(
            children: _buildListTile(saidas),
          ),
        ),
        CardWidget(
          leadingIcon: const Icon(Icons.arrow_downward),
          title: 'Últimas entradas',
          body: Column(
            children: _buildListTile(entradas),
          ),
        ),
      ],
    );
  }

  void _getLastTransactions() async {
    _getLastSaidas();
    _getLastEntradas();
  }

  void _getLastSaidas() async {
    List<TransactionModel> lastSaidas = await _saidaConnection.getLasts();
    setState(() {
      saidas = lastSaidas;
    });
  }

  void _getLastEntradas() async {
    List<TransactionModel> lastentradas = await _entradaConnection.getLasts();
    setState(() {
      entradas = lastentradas;
    });
  }

  List<ListTile> _buildListTile(List<TransactionModel> models) {
    List<ListTile> tiles = [];

    for (TransactionModel model in models) {
      tiles.add(
        ListTile(
          style: ListTileStyle.drawer,
          title: Text(model.descricao),
          trailing: Text('R\$ ${model.valor.toStringAsFixed(2)}'),
          subtitle: Text('${model.data!.day}/${model.data!.month}/${model.data!.year}'),
        ),
      );
    }

    return tiles;
  }
}
