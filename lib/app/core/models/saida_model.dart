import 'basemodel.dart';
import 'cartao_credito_model.dart';
import 'categoria_model.dart';

class SaidaModel extends BaseModel {
  final String descricao;
  final double valor;
  DateTime? data;
  List<CategoriaModel>? categorias;
  CartaoCreditoModel? cartaoCredito;

  SaidaModel({
    int? id,
    required this.descricao,
    required this.valor,
    DateTime? data,
    List<CategoriaModel>? categorias,
    CartaoCreditoModel? cartaoCredito,
  }) : super(id: id);
  
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'descricao': descricao,
      'valor': valor,
      'data': data.toString(),
      'cartaoCredito': cartaoCredito?.toJson(),
    };

    List<Map<String, dynamic>> jsonCategorias = [];
    for(CategoriaModel categoria in categorias!) {
      jsonCategorias.add(categoria.toJson());
    }

    json.addAll(super.toJson());
    json.addAll({'categorias': jsonCategorias});
    return json;
  }
}
