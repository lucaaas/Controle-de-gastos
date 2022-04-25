import 'package:flutter/widgets.dart';

abstract class BaseModel {
  final int? id;
  final DateTime createdAt;

  BaseModel({this.id}) : createdAt = DateTime.now();

  /// Converts this to a [Map<String, dynamic>]
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toString(),
    };
  }
}
