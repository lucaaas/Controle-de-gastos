import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectFieldWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem> _items = [];
  final ValueNotifier<T?> _valueSelected = ValueNotifier(null);

  final String label;
  final OptionSelectWidget<T> Function()? buildItem;
  final List<OptionSelectWidget<T>>? options;
  final Future<OptionSelectWidget<T>?>? Function()? createItem;
  final EdgeInsetsGeometry margin;
  final Icon? icon;
  final void Function(T) onSelect;

  SelectFieldWidget({
    Key? key,
    required this.label,
    required this.options,
    required this.onSelect,
    this.buildItem,
    this.createItem,
    this.margin = const EdgeInsets.all(10.0),
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildItems();

    return ValueListenableBuilder(
      valueListenable: _valueSelected,
      builder: (context, T? value, child) => Container(
        margin: margin,
        child: DropdownButtonFormField(
          icon: icon,
          decoration: InputDecoration(label: Text(label)),
          items: _items,
          onChanged: _onChanged,
          value: value,
          selectedItemBuilder: _selectedItemBuilder,
        ),
      ),
    );
  }

  DropdownMenuItem<T> _buildItem(OptionSelectWidget<T> item) {
    if (buildItem != null) {
      return _buildItem(item);
    } else {
      return DropdownMenuItem(
        value: item.value,
        child: ListTile(
          title: Text(item.label),
          leading: item.icon,
          onTap: item.onTap,
          tileColor: item.color,
        ),
      );
    }
  }

  void _buildItems() {
    if (options != null) {
      _items.addAll(options!.map<DropdownMenuItem<T>>(_buildItem).toList());
    }

    _items.insert(0, const DropdownMenuItem(child: Text(''), value: ''));

    if (createItem != null) {
      _items.add(
        DropdownMenuItem(
          value: null,
          child: SizedBox(
            width: 200,
            child: ListTile(
              title: const Text('Adicionar novo'),
              leading: const Icon(Icons.add),
              onTap: _createNewItem,
            ),
          ),
        ),
      );
    }
  }

  void _createNewItem() async {
    OptionSelectWidget<T>? newItem = await createItem!();
    if (newItem != null) {
      int lastPosition = _items.length;
      _items.insert(lastPosition - 1, _buildItem(newItem));
      _valueSelected.value = newItem.value;

      Modular.to.pop();
    }
  }

  void _onChanged(value) async {
    if (value != null) {
      _valueSelected.value = value;
      onSelect(value);
    }
  }

  List<Widget> _selectedItemBuilder(context) {
    return _items.map<Widget>((item) {
      if (item.value != null) {
        return Text(item.value.toString());
      } else {
        return const Text('');
      }
    }).toList();
  }
}

class OptionSelectWidget<T> {
  final String label;
  final Color? color;
  final Icon? icon;
  final void Function()? onTap;
  final T? value;

  const OptionSelectWidget({
    required this.label,
    this.color,
    this.icon,
    this.onTap,
    this.value,
  });
}
