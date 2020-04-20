import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_slidy/app/shared/models/agendamento_model.dart';
import 'package:projeto_slidy/app/shared/models/profissional_model.dart';
import 'package:projeto_slidy/app/shared/models/servicos_model.dart';
import 'package:projeto_slidy/app/shared/repositories/agendamento_repository.dart';

part 'criaragendamento_controller.g.dart';

class CriaragendamentoController = _CriaragendamentoControllerBase
    with _$CriaragendamentoController;

abstract class _CriaragendamentoControllerBase with Store {
  final AgendamentoRepository repository;
  _CriaragendamentoControllerBase(this.repository);

  @observable
  DateTime selectedDate = DateTime.now();
  @observable
  bool isLoading = false;
  @observable
  TimeOfDay selectedTime = TimeOfDay.now();
  @observable
  int tempoServicos = 0;
  @observable
  List<ProfissionalModel> listaProfissionais = [];
  @observable
  List<ServicosModel> listaServicos = [];
  @observable
  String profissional = "1";
  @observable
  bool checkBarba = false;
  @observable
  bool checkCabelo = false;
  @observable
  bool checkColoracao = false;
  @observable
  bool checkQuimica = false;
  @observable
  bool checkSombrancelha = false;

  @action
  atualizaSelectedDate(day) {
    this.selectedDate = day;
  }

  @action
  atualizaSelectedTime(time) {
    this.selectedTime = time;
  }

  @action
  selecionaProfissional(profissional) {
    this.profissional = profissional;
  }

  @action
  buscarCadastroServicos() async {
    this.listaServicos = await repository.buscarCadastroServicos();
    print("Devolvendo ${this.listaServicos.length} servicos");
  }

  @action
  buscarProfissionais() async {
    this.listaProfissionais = await repository.buscarCadastroProfissionais();
  }

  @action
  checkboxAgendamento(index, value) async {
    this.listaServicos[index].checkbox = !this.listaServicos[index].checkbox;
    if (this.listaServicos[index].checkbox) {
      this.tempoServicos += int.parse(this.listaServicos[index].duracao);
    } else {
      this.tempoServicos -= int.parse(this.listaServicos[index].duracao);
    }
  }

  @action
  incluirAgendamento() async {
    bool isOk = false;
    // isOk = await repository.incluirAgendamento(1, int.parse(profissional), selectedDate, selectedTime, tempoServicos);
    isOk = await repository.incluirAgendamento(AgendamentoModel(
        dia: selectedDate.toString(),
        cliente: "1",
        profissional: profissional,
        hora_inicio: selectedTime.toString().substring(10, 15),
        hora_final: tempoServicos.toString(),
        servicos: "Servicos Selecionados"));
  }
}
