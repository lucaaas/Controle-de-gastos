import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Selectize extends StatelessWidget {
  final String _itemSelecionado = '';

  final List<String> _itensLista;
  final EdgeInsetsGeometry _margin;

  final void Function(String) _onAdd;
  final bool Function(int) _onRemove;

  Selectize({
    required List<String> itensLista,
    required void Function(String) onAdd,
    required bool Function(int) onRemove,
    EdgeInsetsGeometry margin = const EdgeInsets.all(20.0),
    Key? key,
  })  : _itensLista = itensLista,
        _margin = margin,
        _onAdd = onAdd,
        _onRemove = onRemove,
        super(key: key);

  Widget _constroiLista(int index) {
    final item = _itensLista[index];

    return ItemTags(
      index: index,
      title: item,
      pressEnabled: false,
      border: Border.all(width: 1),
      combine: ItemTagsCombine.withTextAfter,
      icon: ItemTagsIcon(icon: Icons.add),
      removeButton: ItemTagsRemoveButton(
        onRemoved: () => _onRemove(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      child: Column(
        children: [
          Tags(
            itemCount: _itensLista.length,
            itemBuilder: _constroiLista,
            columns: 3,
          ),
          TypeAheadField(
            suggestionsCallback: (pattern) => ['item 1', 'item 2', 'item 3']
                .takeWhile((value) => value.contains(pattern)),
            itemBuilder: (context, dynamic itemData) => ListTile(
              leading: Icon(Icons.add),
              title: Text(itemData),
            ),
            onSuggestionSelected: _onAdd,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                labelText: 'Categorias',
                icon: Icon(Icons.category),
              ),
            ),
            noItemsFoundBuilder: (context) => ListTile(
              leading: Icon(Icons.add),
              title: Text('Criar categoria'),
            ),
          ),
        ],
      ),
    );
  }
}
