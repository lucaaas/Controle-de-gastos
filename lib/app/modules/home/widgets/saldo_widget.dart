import 'package:flutter/material.dart';

class SaldoWidget extends StatelessWidget {
  final double realValue;
  final double projectedValue;

  const SaldoWidget({
    required this.realValue,
    required this.projectedValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoWidget(
          label: 'Saldo real',
          value: realValue,
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
          value: projectedValue,
        ),
      ],
    );
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
