import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final List<TextInputFormatter> _inputFormatters;
  final TextInputType _textInputType;
  final bool _readOnly;
  final EdgeInsetsGeometry _margin;
  final Icon? _icon;
  final void Function()? _onTap;
  final String? Function(String?)? _validator;

  const TextFieldWidget({
    required TextEditingController controller,
    required String label,
    TextInputType textInputType = TextInputType.text,
    List<TextInputFormatter> inputFormatters = const [],
    EdgeInsetsGeometry margin = const EdgeInsets.all(10.0),
    bool readOnly = false,
    void Function()? onTap,
    String? Function(String?)? validator,
    Icon? icon,
    Key? key,
  })  : _controller = controller,
        _label = label,
        _icon = icon,
        _textInputType = textInputType,
        _inputFormatters = inputFormatters,
        _readOnly = readOnly,
        _onTap = onTap,
        _margin = margin,
        _validator = validator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      child: TextFormField(
        inputFormatters: _inputFormatters,
        keyboardType: _textInputType,
        controller: _controller,
        onTap: _onTap,
        readOnly: _readOnly,
        decoration: InputDecoration(
          labelText: _label,
          icon: _icon,
        ),
        validator: _validator,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}
