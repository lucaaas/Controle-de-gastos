import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/widgets/card/card_widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_list_widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final String description;
  final String date;
  final Type type;
  final List<CategoriaModel>? categories;

  const TransactionWidget({
    Key? key,
    required this.description,
    required this.date,
    required this.type,
    this.categories = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: description,
      body: TagListWidget(tags: _categoryTags),
      leadingIcon: _leading,
    );
  }

  List<TagWidget> get _categoryTags {
    List<TagWidget> categoryTags = [];
    for (CategoriaModel category in categories!) {
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
    if (type == EntradaModel) {
      return const Icon(Icons.move_to_inbox, color: Colors.green,);
      // return const CircleAvatar(
      //   backgroundColor: Colors.green,
      //   child: Icon(Icons.move_to_inbox),
      // );
    } else {
      return const Icon(Icons.outbox, color: Colors.red);
      // return const CircleAvatar(
      //   backgroundColor: Colors.red,
      //   child: Icon(Icons.outbox),
      // );
    }
  }
}
