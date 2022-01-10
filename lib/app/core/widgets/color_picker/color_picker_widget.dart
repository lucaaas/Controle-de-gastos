import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  final void Function(Color) onSelected;

  const ColorPickerWidget({Key? key, required this.onSelected}) : super(key: key);

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color? _colorSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _generateColorList(),
    );
  }

  List<ChoiceChip> _generateColorList() {
    List<Color> colors = Colors.primaries.sublist(0, 12);
    return List<ChoiceChip>.generate(
      colors.length,
      (index) => ChoiceChip(
        label: const Text(''),
        backgroundColor: colors[index],
        selectedColor: colors[index],
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: _colorSelected == colors[index] ? 3 : 0,
        ),
        shape: const CircleBorder(),
        selected: _colorSelected == colors[index],
        onSelected: (value) => _onSelected(value, colors[index]),
      ),
    );
  }

  void _onSelected(bool value, Color color) {
    setState(() {
      if (value) {
        _colorSelected = color;
        widget.onSelected(color);
      } else {
        _colorSelected = null;
      }
    });
  }
}
