import 'basemodel.dart';
import 'categoria_model.dart';

class EntradaModel extends BaseModel {
  final String descricao;
  final double valor;
  DateTime? data;
  List<CategoriaModel>? categorias;

  EntradaModel({
    int? id,
    required this.descricao,
    required this.valor,
    this.data,
    this.categorias,
  }) : super(id: id);

  EntradaModel.fromJson(Map<String, dynamic> data)
      : descricao = data['descricao'],
        valor = data['valor'],
        data = DateTime.parse(data['data']),
        super(id: data['id']) {
    categorias = [];
    for (Map<String, dynamic> categoria in data['categorias']) {
      categorias!.add(CategoriaModel.fromJson(categoria));
    }
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'descricao': descricao,
      'valor': valor,
      'data': data.toString(),
    };

    json.addAll(super.toJson());

    return json;
  }
}
