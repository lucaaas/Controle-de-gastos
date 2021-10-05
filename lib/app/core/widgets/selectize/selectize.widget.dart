import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectizeWidget<T> extends StatelessWidget {
  final Widget Function(BuildContext, T) _itemBuilder;
  final void Function(T) _onSuggestionSelected;
  final FutureOr<Iterable<T>> Function(String) _suggestionsCallback;
  final Widget Function(BuildContext)? _noItemsFoundBuilder;

  const SelectizeWidget({
    Key? key,
    required Widget Function(BuildContext, T) itemBuilder,
    required void Function(T) onSuggestionSelected,
    required FutureOr<Iterable<T>> Function(String) suggestionsCallback,
    Widget Function(BuildContext)? noItemsFoundBuilder,
  })  : _onSuggestionSelected = onSuggestionSelected,
        _itemBuilder = itemBuilder,
        _suggestionsCallback = suggestionsCallback,
        _noItemsFoundBuilder = noItemsFoundBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      onSuggestionSelected: _onSuggestionSelected,
      itemBuilder: _itemBuilder,
      suggestionsCallback: _suggestionsCallback,
      noItemsFoundBuilder: _noItemsFoundBuilder,
    );
  }
}
