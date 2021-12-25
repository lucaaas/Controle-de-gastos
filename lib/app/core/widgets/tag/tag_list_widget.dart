import 'package:controlegastos/app/core/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';

class TagListWidget extends StatelessWidget {
  final List<TagWidget> _tags;

  const TagListWidget({
    Key? key,
    required List<TagWidget> tags,
  })  : _tags = tags,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [..._tags],
    );
  }
}
