import 'package:controlegastos/app/core/validators/required_validator.dart';
import 'package:controlegastos/app/core/validators/validator_interface.dart';
import 'package:controlegastos/app/core/widgets/date_picker/date_picker_widget.dart';
import 'package:controlegastos/app/core/widgets/form_popup/form_popup.widget.dart';
import 'package:controlegastos/app/modules/categoria_tag_select/categoria_tag_select.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'new_entrada_controller.dart';

class NewEntradaPage extends StatefulWidget {
  const NewEntradaPage({Key? key}) : super(key: key);

  @override
  _NewEntradaPageState createState() => _NewEntradaPageState();
}

class _NewEntradaPageState extends State<NewEntradaPage> {
  final NewEntradaController _controller = Modular.get<NewEntradaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _controller.key,
      appBar: AppBar(
        title: const Text('Nova Entrada'),
      ),
      body: FormPopUpWidget(
        globalKey: _controller.key,
        fields: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Descrição',
              icon: Icon(Icons.textsms),
            ),
            controller: _controller.descricao,
            validator: (value) => ValidatorInterface.validate(value, [RequiredValidator()]),
            autovalidateMode: AutovalidateMode.always,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Valor',
              icon: Icon(Icons.attach_money),
            ),
            controller: _controller.valor,
            validator: (value) => ValidatorInterface.validate(value, [RequiredValidator()]),
            autovalidateMode: AutovalidateMode.always,
            keyboardType: TextInputType.number,
            inputFormatters: [
              TextInputMask(mask: 'R!\$! !9+ 999.99', placeholder: '0', maxPlaceHolders: 0, reverse: true)
            ],
          ),
          DatePickerWidget(
            textEditingController: _controller.data,
            firstDate: DateTime(DateTime.now().year - 1),
          ),
          CategoriaTagSelect(
            categorias: _controller.categorias,
            globalKey: _controller.key,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: _controller.save,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
