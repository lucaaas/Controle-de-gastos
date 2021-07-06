import 'package:flutter/material.dart';

class NewEntradaController {
  Future<String> openDatePicker(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      return '${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}';
    } else {
      return '';
    }
  }
}
