import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Selectize extends StatefulWidget {
  const Selectize({Key? key}) : super(key: key);

  @override
  _SelectizeState createState() => _SelectizeState();
}

class _SelectizeState extends State<Selectize> {
  final String _itemSelecionado = '';
  final List<String> _itensLista = [];

  void _addItemLista(String item) {
    setState(() {
      _itensLista.add(item);
    });
  }

  void _atualizaLista(String item) {
    if (!_itensLista.contains(item)) {
      setState(() {
        _itensLista.add(item);
      });
    }
  }

  bool _removeItemLista(int index) {
    setState(() {
      _itensLista.removeAt(index);
    });

    return true;
  }

  // void _constroiLista() {
  //   const List<String> itens = ['item 1', 'item 2', 'item 3'];
  //   List<GestureDetector> componentes = [];
  //   for (var item in itens) {
  //     componentes.add(
  //       GestureDetector(
  //         child: Container(
  //           child: TextField(
  //             controller: TextEditingController(text: item),
  //             // decoration: InputDecoration(icon: IconData()),
  //             enabled: false,
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           color: (_itemSelecionado == item
  //               ? Colors.purple
  //               : Colors.orangeAccent),
  //           alignment: Alignment.center,
  //           margin: EdgeInsets.all(2),
  //           padding: EdgeInsets.all(10),
  //         ),
  //         onTap: () => _addItemLista(item),
  //       ),
  //     );
  //   }
  //
  //   _atualizaLista(componentes);
  // }

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
        onRemoved: () => _removeItemLista(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25.0, bottom: 20.0),
      child: Column(
        children: [
          Tags(
            itemCount: _itensLista.length,
            itemBuilder: _constroiLista,
            columns: 3,
            // textField: TagsTextField(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   constraintSuggestion: false,
            //   enabled: false,
            //   autofocus: false,
            //   suggestions: ['item 1', 'item 2', 'item 3'],
            //   helperText: 'Insira uma ou mais categorias',
            //   inputDecoration: InputDecoration(
            //     labelText: 'Categorias',
            //     icon: Icon(Icons.category),
            //   ),
            //   onSubmitted: _addItemLista,
            // ),
          ),
          TypeAheadField(
            suggestionsCallback: (pattern) => ['item 1', 'item 2', 'item 3']
                .takeWhile((value) => value.contains(pattern)),
            itemBuilder: (context, dynamic itemData) => ListTile(
              leading: const Icon(Icons.add),
              title: Text(itemData),
            ),
            onSuggestionSelected: _addItemLista,
            textFieldConfiguration: const TextFieldConfiguration(
              decoration: InputDecoration(
                labelText: 'Categorias',
                icon: Icon(Icons.category),
              ),
            ),
            noItemsFoundBuilder: (context) => const ListTile(
              leading: Icon(Icons.add),
              title: Text('Criar categoria'),

            ),

          ),
        ],
      ),
    );
  }
}
//   Widget build(BuildContext context) {
//     _constroiLista();
//     return Card(
//       child: Column(
//         children: [
//           TextField(),
//           Text(_itemSelecionado),
//           SingleChildScrollView(
//             child: Container(
//               child: ListBody(
//                 children: _itensLista,
//                 // [
//                 //   ListView.builder(
//                 //     itemCount: _itensLista.length,
//                 //     itemBuilder: (context, index) {
//                 //       _constroiLista();
//                 //
//                 //       final item = _itensLista[index];
//                 //       return item;
//                 //     },
//                 //   ),
//                 // GestureDetector(
//                 //   child: Container(
//                 //     child: Text('teste 1'),
//                 //     color: (_itemSelecionado == 'teste 1'
//                 //         ? Colors.purple
//                 //         : Colors.orangeAccent),
//                 //     alignment: Alignment.center,
//                 //   ),
//                 //   onTap: () => _addItemLista('teste 1'),
//                 // ),
//                 // ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
