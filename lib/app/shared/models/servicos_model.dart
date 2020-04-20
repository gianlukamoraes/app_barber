class ServicosModel {
  final int id;
  final String nome;
  final String duracao;
  bool checkbox;

  ServicosModel({this.id, this.nome, this.duracao, this.checkbox});

  factory ServicosModel.fromJson(Map<String, dynamic> json) {
    return ServicosModel(
      id: json['id'],
      nome: json['nome'],
      duracao: json['duracao'],
      checkbox: false
    );
  }

  Map<String, dynamic> toJson(ServicosModel user) => {
        // 'id': id,
        'id': id,
        'nome': nome,
        'duracao': duracao,
        'checkbox': checkbox
      };
}
