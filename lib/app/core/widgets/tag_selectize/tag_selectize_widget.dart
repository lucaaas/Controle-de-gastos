import 'dart:async';

import 'package:controlegastos/app/core/widgets/selectize/selectize.widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_list_widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';

class TagSelectizeWidget<T> extends StatelessWidget {
  final ValueNotifier<List<TagWidget>> _tags = ValueNotifier([]);

  final List<T> _items;
  final Widget Function(BuildContext, T) _itemBuilder;
  final InfoTag Function(T) _getInfoTag;
  final FutureOr<Iterable<T>> Function(String) _suggestionsCallback;
  final InputDecoration _inputDecoration;
  final Widget Function(BuildContext)? _noItemsFoundBuilder;

  TagSelectizeWidget({
    Key? key,
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    required InfoTag Function(T) getInfoTag,
    required FutureOr<Iterable<T>> Function(String) suggestionsCallback,
    required InputDecoration inputDecoration,
    Widget Function(BuildContext)? noItemsFoundBuilder,
  })  : _items = items,
        _itemBuilder = itemBuilder,
        _getInfoTag = getInfoTag,
        _inputDecoration = inputDecoration,
        _suggestionsCallback = suggestionsCallback,
        _noItemsFoundBuilder = noItemsFoundBuilder,
        super(key: key) {
    _getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectizeWidget(
          itemBuilder: _itemBuilder,
          onSuggestionSelected: _onSuggestionSelected,
          suggestionsCallback: _suggestionsCallback,
          noItemsFoundBuilder: _noItemsFoundBuilder,
          inputDecoration: _inputDecoration,
        ),
        ValueListenableBuilder(
          valueListenable: _tags,
          builder: (context, List<TagWidget> tags, child) => TagListWidget(tags: tags),
        ),
      ],
    );
  }

  TagWidget _buildTag(T item) {
    InfoTag infoTag = _getInfoTag(item);
    return TagWidget(
      text: infoTag.label,
      color: infoTag.color,
      onDeleted: () => onDeletedTag(item),
    );
  }

  void _getTags() {
    List<TagWidget> tags = [];
    if (_items.isNotEmpty) {
      for (T item in _items) {
        tags.add(_buildTag(item));
      }
    }

    _tags.value = tags;
  }

  void onDeletedTag(T item) {
    _items.remove(item);
    _getTags();
  }

  void _onSuggestionSelected(T valueSelected) {
    _items.add(valueSelected);
    _tags.value = List.from(_tags.value)..add(_buildTag(valueSelected));
  }

}

class InfoTag {
  String label;
  Color color;

  InfoTag({required this.label, required this.color});
}
