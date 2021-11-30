import 'package:controlegastos/app/core/widgets/form_popup/form_popup.widget.dart';
import 'package:controlegastos/app/core/widgets/selectize/selectize.widget.dart';
import 'package:controlegastos/app/core/widgets/tag_selectize/tag_selectize_widget.dart';
import 'package:controlegastos/app/core/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'new_entrada_controller.dart';

class NewEntradaPage extends StatefulWidget {
  const NewEntradaPage({Key? key}) : super(key: key);

  @override
  _NewEntradaPageState createState() => _NewEntradaPageState();
}

class _NewEntradaPageState extends State<NewEntradaPage> {
  final NewEntradaController _controller = Modular.get<NewEntradaController>();
  final TextEditingController _descricao = TextEditingController();
  final TextEditingController _valor = TextEditingController();
  final TextEditingController _data = TextEditingController();

  final newEntradaController = NewEntradaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Entrada'),
      ),
      body: FormPopUpWidget(
        fields: [
          TextField(
            decoration: const InputDecoration(
                labelText: 'Descrição', icon: Icon(Icons.textsms)),
            controller: _descricao,
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: 'Valor', icon: Icon(Icons.attach_money)),
            controller: _valor,
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: 'Data', icon: Icon(Icons.date_range)),
            controller: _data,
            readOnly: true,
            onTap: _showDatePicker,
          ),
          const Selectize(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () => print('salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
