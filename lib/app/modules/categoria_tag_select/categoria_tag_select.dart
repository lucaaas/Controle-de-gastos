import 'package:controlegastos/app/core/models/categoria_model.dart';
import 'package:controlegastos/app/core/widgets/tag_selectize/tag_selectize_widget.dart';
import 'package:controlegastos/app/modules/categoria_tag_select/categoria_tag_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriaTagSelect extends StatelessWidget {
  final CategoriaTagSelectController _controller = Modular.get<CategoriaTagSelectController>();

  CategoriaTagSelect({Key? key, required GlobalKey globalKey, required List<CategoriaModel> categorias})
      : super(key: key) {
    _controller.categorias.value = categorias;
    _controller.key = globalKey;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller.categorias,
      builder: (context, List<CategoriaModel> value, child) => TagSelectizeWidget<CategoriaModel>(
        key: key,
        itemBuilder: _controller.itemBuilder,
        suggestionsCallback: _controller.suggestionsCallback,
        getInfoTag: _controller.getInfoTags,
        noItemsFoundBuilder: _controller.noItemsFoundBuilder,
        items: value,
        inputDecoration: const InputDecoration(
          labelText: 'Categorias',
          icon: Icon(Icons.label),
        ),
      ),
    );
  }
}
