import 'package:controlegastos/app/core/models/appconfig_model.dart';
import 'package:flutter/material.dart';

class NewEntradaController {
  final AppConfigModel appConfigModel;

  final ValueNotifier<List<String>> itensLista = ValueNotifier([]);
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController data = TextEditingController();

  NewEntradaController(this.appConfigModel);

  Future<void> openDatePicker(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      data.text = '${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}';
    } else {
      data.text = '';
    }
  }

  void addItemLista(String item) {
    if (!itensLista.value.contains(item)) {
      itensLista.value.add(item);
    }
  }

  bool removeItemLista(int index) {
    itensLista.value.removeAt(index);
    return true;
  }
}
