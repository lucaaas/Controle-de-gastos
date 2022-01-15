import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final EdgeInsets margin;
  final void Function() onPressed;

  const DefaultButton({Key? key, required this.label, required this.onPressed, this.margin = const EdgeInsets.all(2.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: margin,
        child: ElevatedButton(
          child: Text(label),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
