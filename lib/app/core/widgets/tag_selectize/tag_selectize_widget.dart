import 'dart:async';

import 'package:controlegastos/app/core/widgets/selectize/selectize.widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_list_widget.dart';
import 'package:controlegastos/app/core/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';

class TagSelectizeWidget<T> extends StatelessWidget {
  final ValueNotifier<List<TagWidget>> _tags = ValueNotifier([]);

  final List<T> _items;
  final Widget Function(BuildContext, T) _itemBuilder;
  final TagWidget Function(T) _buildTag;
  final FutureOr<Iterable<T>> Function(String) _suggestionsCallback;
  final Widget Function(BuildContext)? _noItemsFoundBuilder;

  TagSelectizeWidget({
    Key? key,
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    required TagWidget Function(T) buildTag,
    required FutureOr<Iterable<T>> Function(String) suggestionsCallback,
    Widget Function(BuildContext)? noItemsFoundBuilder,
  })  : _items = items,
        _itemBuilder = itemBuilder,
        _buildTag = buildTag,
        _suggestionsCallback = suggestionsCallback,
        _noItemsFoundBuilder = noItemsFoundBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SelectizeWidget(
            itemBuilder: _itemBuilder,
            onSuggestionSelected: _onSuggestionSelected,
            suggestionsCallback: _suggestionsCallback,
            noItemsFoundBuilder: _noItemsFoundBuilder,
          ),
          ValueListenableBuilder(
            valueListenable: _tags,
            builder: (context, List<TagWidget> tags, child) => TagListWidget(tags: tags),
          ),
        ],
      ),
    );
  }

  void _onSuggestionSelected(T valueSelected) {
    _items.add(valueSelected);
    _tags.value.add(_buildTag(valueSelected));
  }
}
