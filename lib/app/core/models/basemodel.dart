import 'package:flutter/widgets.dart';

abstract class BaseModel {
  final int? id;

  BaseModel({this.id});

  /// Converts this to a [Map<String, dynamic>]
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
