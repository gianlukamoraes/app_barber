import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_slidy/app/shared/models/agendamento_model.dart';
import 'package:projeto_slidy/app/shared/repositories/agendamento_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final Dio dio = Dio();
  final AgendamentoRepository repository;

  @observable
  List<AgendamentoModel> agendamentos = [];
  
  _HomeControllerBase(this.repository);

  @action
  buscarAgendamentosDia(dia) async {
    this.agendamentos = await repository.buscarAgendamentosDia(dia);
    print("Devolvendo ${this.agendamentos.length} agendamentos");
  }
  
  // @action
  // limpaAgendamentosNaMemoria() {
  //   print("Limpa Agendamentos ${this.agendamentos.length} agendamentos");    
  //   this.agendamentos = [];
  // }
}
