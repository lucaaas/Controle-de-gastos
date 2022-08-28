import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final String description;
  final String date;
  final Type type;

  const TransactionWidget({
    Key? key,
    required this.description,
    required this.date,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(
        child: _leading,
      ),
      title: Text(description),
      subtitle: Text(date),
    );
  }

  CircleAvatar get _leading {
    if (type == EntradaModel) {
      return const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.move_to_inbox),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.outbox),
      );
    }
  }
}
