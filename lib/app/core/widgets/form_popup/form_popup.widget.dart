import 'package:flutter/material.dart';

class FormPopUpWidget extends StatelessWidget {
  final List<Widget> fields;
  final GlobalKey<FormState> globalKey;

  const FormPopUpWidget({required this.fields, required this.globalKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: fields,
            ),
          ),
        ),
      ),
    );
  }
}
