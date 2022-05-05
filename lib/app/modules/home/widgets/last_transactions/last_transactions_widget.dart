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

  late List<SaidaModel> saidas;

  @override
  void initState() {
    saidas = [];
    _getLastSaidas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      leadingIcon: const Icon(Icons.arrow_upward),
      title: 'Últimas saídas',
      body: Column(
        children: _buildListTile(saidas),
      ),
    );
  }

  void _getLastSaidas() async {
    List<SaidaModel> lastSaidas = await _saidaConnection.getLasts();
    setState(() {
      saidas = lastSaidas;
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
          subtitle: Text(model.data.toString()),
        ),
      );
    }

    return tiles;
  }
}
