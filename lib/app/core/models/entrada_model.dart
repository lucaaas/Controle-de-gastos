import 'categoria_model.dart';
import 'basemodel.dart';

class EntradaModel extends BaseModel  {
  final String descricao;
  final double valor;
  DateTime? data;
  List<CategoriaModel>? categorias;

  EntradaModel({
    int? id,
    required this.descricao,
    required this.valor,
    DateTime? data,
    List<CategoriaModel>? categorias,
  }) : super(id: id) ;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'descricao': descricao,
      'valor': valor,
      'data': data.toString(),
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
