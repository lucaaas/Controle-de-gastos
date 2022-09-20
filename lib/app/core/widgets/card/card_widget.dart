import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget? subtitle;
  final Icon? leadingIcon;
  final String? title;
  final Widget? body;
  final bool isThreeLine;

  const CardWidget({
    this.body,
    this.subtitle,
    this.title,
    this.leadingIcon,
    this.isThreeLine = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: Column(
        children: [
          ListTile(
            leading: leadingIcon,
            isThreeLine: isThreeLine,
            title: Text(
              title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: subtitle,
          ),
          Padding(
            padding: EdgeInsets.all(body != null ? 16.0 : 0.0),
            child: body,
          ),
        ],
      ),
    );
    ;
  }
}
