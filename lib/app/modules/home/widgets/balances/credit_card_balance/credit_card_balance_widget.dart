import 'package:controlegastos/app/core/models/cartao_credito_model.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:controlegastos/app/core/widgets/card/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreditCardBalanceWidget extends StatefulWidget {
  const CreditCardBalanceWidget({Key? key}) : super(key: key);

  @override
  State<CreditCardBalanceWidget> createState() => _CreditCardBalanceWidgetState();
}

class _CreditCardBalanceWidgetState extends State<CreditCardBalanceWidget> {
  final SaidaConnection _saidaConnection = Modular.get<SaidaConnection>();

  late Map<CartaoCreditoModel, double> creditCardsBalance;

  @override
  void initState() {
    creditCardsBalance = {};

    _getCreditCardsBalance();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (creditCardsBalance.isNotEmpty) {
      return CardWidget(
        leadingIcon: const Icon(Icons.credit_card),
        title: 'Cartões de crédito',
        body: Column(
          children: _buildCreditCardsList(),
        ),
      );
    } else {
      return Container();
    }
  }

  List<ListTile> _buildCreditCardsList() {
    List<ListTile> creditCardTiles = [];

    for (CartaoCreditoModel cartaoCredito in creditCardsBalance.keys) {
      creditCardTiles.add(
        ListTile(
          style: ListTileStyle.drawer,
          title: Text(cartaoCredito.nome),
          trailing: Text('R\$ ${creditCardsBalance[cartaoCredito]!.toStringAsFixed(2)}'),
          tileColor: cartaoCredito.cor,
        ),
      );
    }

    return creditCardTiles;
  }

  void _getCreditCardsBalance() async {
    Map<CartaoCreditoModel, double> balances = await _saidaConnection.getCreditCardsBalance();
    setState(() {
      creditCardsBalance = balances;
    });
  }
}
