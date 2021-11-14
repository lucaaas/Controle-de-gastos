import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormPopUpWidget extends StatelessWidget {
  final List<Widget>? _fields;

  const FormPopUpWidget({List<Widget>? fields, Key? key})
      : _fields = fields,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              children: _fields!,
            ),
          ),
        ),
      ),
    );
  }
}
