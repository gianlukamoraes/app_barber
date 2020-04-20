class ProdutoModel {
  final int id;
  final String nome;
  final String marca;
  final String codbar;
  final String unidademedida;

  ProdutoModel({this.id, this.nome, this.marca, this.codbar, this.unidademedida});

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    
    return ProdutoModel(
        id: json['_id'],
        nome: json['nome'],
        marca: json['marca'],
        codbar: json['codbar'],
        unidademedida: json['unidademedida'],
        );
  }

  Map<String, dynamic> toJson(ProdutoModel produto) => {
    // 'id': id,
    'nome': nome,
    'marca': marca,
    'codbar': codbar,
    'unidademedida' : unidademedida
  };
}