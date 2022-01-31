import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final EdgeInsets margin;
  final TextEditingController textEditingController;
  late DateTime initialDate;
  late DateTime firstDate;
  late DateTime lastDate;

  DatePickerWidget({
    Key? key,
    required this.textEditingController,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    this.margin = const EdgeInsets.all(10.0),
  }) : super(key: key) {
    this.initialDate = initialDate ?? DateTime.now();
    this.firstDate = firstDate ?? DateTime.now();
    this.lastDate = lastDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Data',
          icon: Icon(Icons.date_range),
        ),
        controller: textEditingController,
        readOnly: true,
        onTap: () => _openDatePicker(context),
      ),
    );
  }

  Future<void> _openDatePicker(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (dataSelecionada != null) {
      textEditingController.text = dataSelecionada.toString().split(' ')[0];
    } else {
      textEditingController.text = '';
    }
  }
}
