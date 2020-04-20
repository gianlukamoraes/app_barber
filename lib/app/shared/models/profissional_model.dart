class ProfissionalModel {
  final int id;
  final String nome;

  ProfissionalModel({this.id, this.nome});

  factory ProfissionalModel.fromJson(Map<String, dynamic> json) {
    return ProfissionalModel(id: json['id'], nome: json['nome']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'nome': nome};
}
