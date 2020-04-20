class ListasModel {
  final int id;
  final String nome;
  final String local;
  final String data;

  ListasModel({this.id, this.nome, this.local, this.data});

  factory ListasModel.fromJson(Map<String, dynamic> json) {
    
    return ListasModel(
        id: json['id'],
        nome: json['nome'],
        local: json['local'],
        data: json['data']
        );
  }

  Map<String, dynamic> toJson(ListasModel produto) => {
    // 'id': id,
    'nome': nome,
    'local': local,
    'data': data
  };
}
