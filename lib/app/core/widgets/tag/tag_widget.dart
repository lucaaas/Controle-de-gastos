import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final String _text;
  final Color? _color;
  final void Function()? _onDeleted;
  final CircleAvatar? _thumbnail;

  const TagWidget({
    Key? key,
    required String text,
    CircleAvatar? thumbnail,
    Color? color,
    void Function()? onDeleted,
  })  : _text = text,
        _color = color,
        _onDeleted = onDeleted,
        _thumbnail = thumbnail,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InputChip(
        label: Text(_text),
        avatar: _thumbnail,
        backgroundColor: _color,
        onDeleted: _onDeleted,
      ),
    );
  }
}
