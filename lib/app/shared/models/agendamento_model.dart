class AgendamentoModel {
  final int id;
  final String dia;
  final String hora_inicio;
  final String hora_final;
  final String cliente;
  final String profissional;
  final String servicos;

  AgendamentoModel(
      {this.id,
      this.dia,
      this.hora_inicio,
      this.hora_final,
      this.cliente,
      this.profissional,
      this.servicos});

  factory AgendamentoModel.fromJson(Map<String, dynamic> json) {
    return AgendamentoModel(
        id: json['id'],
        dia: json['dia'],
        hora_inicio: json['hora_inicio'],
        hora_final: json['hora_final'],
        cliente: json['cliente'],
        profissional: json['profissional'],
        servicos: json['servicos']);
  }

  Map<String, dynamic> toJson(AgendamentoModel agendamento) => {
        'id': id,
        'dia': dia,
        'hora_inicio': hora_inicio,
        'hora_final': hora_final,
        'cliente': cliente,
        'profissional': profissional,
        'servicos' : servicos
      };
}
