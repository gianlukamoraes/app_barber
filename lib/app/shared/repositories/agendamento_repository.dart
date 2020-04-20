import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:projeto_slidy/app/shared/models/agendamento_model.dart';
import 'package:projeto_slidy/app/shared/models/profissional_model.dart';
import 'package:projeto_slidy/app/shared/models/servicos_model.dart';

class AgendamentoRepository extends Disposable {
  final Dio dio;

  AgendamentoRepository(this.dio);

  /* 
    * Consome a API que retorna os agendamentos já existentes para o dia selecionado.
  */
  Future<List<AgendamentoModel>> buscarAgendamentosDia(dia) async {
    List<AgendamentoModel> agendamentos = [];
    final data = dia.toString().substring(0, 4) +
        '-' +
        dia.toString().substring(5, 7) +
        '-' +
        dia.toString().substring(8, 10);

    final response = await dio.get(
      "http://10.1.1.106:3030/agendamentos/filtrar?data=$data",
    );
    var items = response.data;

    for (var i = 0; i < items.length; i++) {
      AgendamentoModel agenda = AgendamentoModel.fromJson(items[i]);

      agendamentos.add(agenda);
    }
    return agendamentos;
  }

  /* 
    * Consome a API que retorna os serviços cadastrados no back-end.
  */
  Future<List<ServicosModel>> buscarCadastroServicos() async {
    List<ServicosModel> servicos = [];

    final response = await dio.get(
      "http://10.1.1.106:3030/servicos",
    );
    var items = response.data;

    for (var i = 0; i < items.length; i++) {
      ServicosModel serv = ServicosModel.fromJson(items[i]);

      servicos.add(serv);
    }
    return servicos;
  }

  /* 
    * Consome a API que retorna os profissionais (barbeiros) cadastrados no back-end.
  */
  Future<List<ProfissionalModel>> buscarCadastroProfissionais() async {
    print("Buscando Profissionais.");
    Dio dio = Dio();

    List<ProfissionalModel> profissionais = [];

    final response = await dio.get("http://10.1.1.106:3030/profissionais/get");

    var items = response.data;

    for (var i = 0; i < items.length; i++) {
      ProfissionalModel prof = ProfissionalModel.fromJson(items[i]);

      profissionais.add(prof);
    }
    return profissionais;
  }

  /* 
    * Consome a API que valida se o horario para o novo agendamento é válido.
  */
  // incluirAgendamento(int idUsuario, int idProfissional, DateTime data,
  //     TimeOfDay hora, int tempoServicos) async {
  incluirAgendamento(AgendamentoModel agendamento) async {
    print("Validando Inclusão de Agendamento");
    Dio dio = Dio();

    final response = await dio
        .post("http://10.1.1.106:3030/agendamentos/agendar", data: agendamento.toJson(agendamento));
  }

  @override
  void dispose() {}
}
