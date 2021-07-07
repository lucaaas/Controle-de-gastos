import 'package:controlegastos/app/core/widgets/form_popup/form_popup.widget.dart';
import 'package:controlegastos/app/core/widgets/selectize/selectize.widget.dart';
import 'package:controlegastos/app/core/widgets/text_field/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'new_entrada_controller.dart';

class NewEntradaPage extends StatefulWidget {
  _NewEntradaPageState createState() => _NewEntradaPageState();
}

class _NewEntradaPageState extends State<NewEntradaPage> {
  final NewEntradaController _controller = Modular.get<NewEntradaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Entrada'),
      ),
      body: FormPopUpWidget(
        fields: [
          TextFieldWidget(
            label: 'Descrição',
            icon: Icon(Icons.sms),
            margin: _controller.appConfigModel.margin,
            controller: _controller.descricao,
          ),
          TextFieldWidget(
            label: 'Valor',
            icon: Icon(Icons.attach_money),
            controller: _controller.valor,
          ),
          TextFieldWidget(
            label: 'Data',
            icon: Icon(Icons.date_range),
            controller: _controller.data,
            readOnly: true,
            onTap: () => _controller.openDatePicker(context),
          ),
          ValueListenableBuilder(
            valueListenable: _controller.itensLista,
            builder: (context, List<String> value, child) => Selectize(
              itensLista: value,
              margin: _controller.appConfigModel.margin,
              onAdd: _controller.addItemLista,
              onRemove: _controller.removeItemLista,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Text('Salvar'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: () => print('salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
