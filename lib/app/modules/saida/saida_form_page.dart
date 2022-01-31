import 'package:controlegastos/app/core/validators/required_validator.dart';
import 'package:controlegastos/app/core/validators/validator_interface.dart';
import 'package:controlegastos/app/core/widgets/date_picker/date_picker_widget.dart';
import 'package:controlegastos/app/core/widgets/form_popup/form_popup.widget.dart';
import 'package:controlegastos/app/core/widgets/text_field/text_field_widget.dart';
import 'package:controlegastos/app/modules/cartao_credito/widgets/select_cartao_credito_widget.dart';
import 'package:controlegastos/app/modules/categoria_tag_select/categoria_tag_select.dart';
import 'package:controlegastos/app/modules/saida/saida_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SaidaFormPage extends StatelessWidget {
  final SaidaFormController _controller = Modular.get<SaidaFormController>();

  SaidaFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _controller.key,
      appBar: AppBar(
        title: const Text('Saída'),
      ),
      body: FormPopUpWidget(
        globalKey: _controller.key,
        fields: [
          TextFieldWidget(
            controller: _controller.descricao,
            label: 'Descrição',
            icon: const Icon(Icons.sms),
            validator: (value) => ValidatorInterface.validate(value, [RequiredValidator()]),
          ),
          TextFieldWidget(
            controller: _controller.valor,
            label: 'Valor',
            icon: const Icon(Icons.attach_money),
            validator: (value) => ValidatorInterface.validate(value, [RequiredValidator()]),
          ),
          DatePickerWidget(
            textEditingController: _controller.data,
            firstDate: DateTime(DateTime.now().year - 1),
          ),
          CategoriaTagSelect(
            categorias: _controller.categorias,
            globalKey: _controller.key,
          ),
          SelectCartaoCreditoWidget(onSelect: _controller.onSelectCartao,),
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
