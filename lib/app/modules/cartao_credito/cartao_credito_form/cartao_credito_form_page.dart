import 'package:controlegastos/app/core/validators/required_validator.dart';
import 'package:controlegastos/app/core/validators/validator_interface.dart';
import 'package:controlegastos/app/core/widgets/buttons/defult_button.dart';
import 'package:controlegastos/app/core/widgets/color_picker/color_picker_widget.dart';
import 'package:controlegastos/app/core/widgets/form_popup/form_popup.widget.dart';
import 'package:controlegastos/app/modules/cartao_credito/cartao_credito_form/cartao_credito_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CartaoCreditoFormPage extends StatelessWidget {
  CartaoCreditoFormController _controller = Modular.get<CartaoCreditoFormController>();

  CartaoCreditoFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cartão de Crédito')),
      body: FormPopUpWidget(
        globalKey: _controller.key,
        fields: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nome',
              icon: Icon(Icons.category),
            ),
            controller: _controller.nome,
            validator: (value) => ValidatorInterface.validate(value, [RequiredValidator()]),
            autovalidateMode: AutovalidateMode.always,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Cor', icon: Icon(Icons.color_lens)),
            enabled: false,
          ),
          ColorPickerWidget(onSelected: _controller.onColorSelected),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              DefaultButton(label: 'Cancelar', onPressed: _controller.cancelar),
              DefaultButton(label: 'Salvar', onPressed: _controller.save),
            ],
          ),
        ],
      ),
    );
  }
}
