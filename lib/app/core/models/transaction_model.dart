import 'package:controlegastos/app/core/models/basemodel.dart';
import 'package:controlegastos/app/core/models/categoria_model.dart';

class TransactionModel extends BaseModel {
  final String descricao;
  final double valor;
  DateTime? data;
  List<CategoriaModel>? categorias;

  TransactionModel({
    int? id,
    required this.descricao,
    required this.valor,
    this.data,
    this.categorias,
  }) : super(id: id);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'descricao': descricao,
      'valor': valor,
      'data': data?.toString(),
    };

    json.addAll(super.toJson());

    return json;
  }

  String get formattedDate {
    if (data != null) {
      String day = data!.day.toString().padLeft(2, '0');
      String month = data!.month.toString().padLeft(2, '0');
      String year = data!.year.toString();

      return '$day/$month/$year';
    } else {
      return '';
    }
  }
}