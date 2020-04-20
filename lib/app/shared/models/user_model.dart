class UserModel {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final String telefone;
  final bool confirmado;
  final bool bloqueado;

  UserModel(
      {this.id,
      this.nome,
      this.email,
      this.senha,
      this.telefone,
      this.confirmado,
      this.bloqueado});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      telefone: json['telefone'],
      confirmado: json['confirmado'],
      bloqueado: json['bloqueado'],
    );
  }

  Map<String, dynamic> toJson(UserModel user) => {
        // 'id': id,
        'nome': nome,
        'email': email,
        'senha': senha,
        'telefone': telefone,
        'confirmado': confirmado,
        'bloqueado': bloqueado
      };
}
