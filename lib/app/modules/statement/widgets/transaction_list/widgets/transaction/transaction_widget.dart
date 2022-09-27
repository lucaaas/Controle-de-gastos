import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/widgets/card/card_widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_list_widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: CardWidget(
        isThreeLine: true,
        title: transaction.descricao,
        leadingIcon: _leading,
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.formattedValue,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(transaction.formattedDate),
            TagListWidget(tags: _categoryTags),
          ],
        ),
      ),
    );
  }

  List<TagWidget> get _categoryTags {
    List<TagWidget> categoryTags = [];

    for (CategoriaModel category in transaction.categorias!) {
      categoryTags.add(
        TagWidget(
          text: category.nome,
          color: category.cor,
        ),
      );
    }

    return categoryTags;
  }

  Icon get _leading {
    if (transaction.runtimeType == EntradaModel) {
      return const Icon(Icons.move_to_inbox, color: Colors.green);
    } else {
      return const Icon(Icons.outbox, color: Colors.red);
    }
  }
}
