import 'package:controlegastos/widgets/form_popup/form_popup.widget.dart';
import 'package:controlegastos/widgets/selectize/selectize.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'new_entrada_controller.dart';

class NewEntradaPage extends StatefulWidget {
  _NewEntradaPageState createState() => _NewEntradaPageState();
}

class _NewEntradaPageState extends State<NewEntradaPage> {
  final TextEditingController _descricao = TextEditingController();
  final TextEditingController _valor = TextEditingController();
  final TextEditingController _data = TextEditingController();

  final newEntradaController = new NewEntradaController();

  _showDatePicker() async {
    String data = await newEntradaController.openDatePicker(context);
    _data.value = TextEditingValue(text: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormPopUpWidget(
        fields: [
          TextField(
            decoration: InputDecoration(
                labelText: 'Descrição', icon: Icon(Icons.textsms)),
            controller: _descricao,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Valor', icon: Icon(Icons.attach_money)),
            controller: _valor,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Data', icon: Icon(Icons.date_range)),
            controller: _data,
            readOnly: true,
            onTap: _showDatePicker,
          ),
          Selectize(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Text('Salvar'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => print('salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
