import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Icon? leadingIcon;
  final String? title;
  final Widget? body;

  const CardWidget({this.body, this.title, this.leadingIcon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: Column(
        children: [
          ListTile(
            leading: leadingIcon,
            title: Text(
              title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: body,
          ),
        ],
      ),
    );
    ;
  }
}
