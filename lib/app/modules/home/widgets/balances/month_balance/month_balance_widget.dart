import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MonthBalanceWidget extends StatefulWidget {
  const MonthBalanceWidget({Key? key}) : super(key: key);

  @override
  State<MonthBalanceWidget> createState() => _MonthBalanceWidgetState();
}

class _MonthBalanceWidgetState extends State<MonthBalanceWidget> {
  final EntradaConnection _entradaConnection = Modular.get<EntradaConnection>();
  final SaidaConnection _saidaConnection = Modular.get<SaidaConnection>();

  late double availableBalance;
  late double futureBalance;

  @override
  void initState() {
    availableBalance = 0;
    futureBalance = 0;

    _getBalances();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoWidget(
          label: 'Saldo disponível',
          value: availableBalance,
        ),
        SizedBox(
          height: 75,
          width: 0,
          child: VerticalDivider(
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        _InfoWidget(
          label: 'Saldo ao fim do mês',
          value: futureBalance,
        ),
      ],
    );
  }

  void _getBalances() {
    _getAvaiableBalance();
    _getFutureBalance();
  }

  Future<void> _getAvaiableBalance() async {
    double totalEntrada = await _entradaConnection.getTotal();
    double totalSaida = await _saidaConnection.getTotal();

    setState(() {
      availableBalance = totalEntrada - totalSaida;
    });
  }

  Future<void> _getFutureBalance() async {
    double totalEntrada = await _entradaConnection.getFutureBalance();
    double totalSaida = await _saidaConnection.getFutureBalance();
    setState(() {
      futureBalance = totalEntrada - totalSaida;
    });
  }
}

class _InfoWidget extends StatelessWidget {
  static const double _margin = 15.0;
  final String label;
  final double value;

  const _InfoWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: _margin),
        margin: const EdgeInsets.symmetric(vertical: _margin),
        child: TextFormField(
          controller: TextEditingController(text: 'R\$ ${value.toStringAsFixed(2)}'),
          enabled: false,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),
          ),
          style: TextStyle(
            color: value > 0 ? Colors.green : Colors.red,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
