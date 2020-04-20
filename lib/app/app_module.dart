import 'package:projeto_slidy/app/modules/meusagendamentos/meusagendamentos_controller.dart';
import 'package:projeto_slidy/app/shared/repositories/login_repository.dart';
import 'package:projeto_slidy/app/shared/repositories/agendamento_repository.dart';
import 'package:projeto_slidy/app/modules/horariosdisponiveis/horariosdisponiveis_controller.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/criaragendamento_controller.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/criaragendamento_module.dart';
import 'package:projeto_slidy/app/modules/login/login_controller.dart';
import 'package:dio/dio.dart';
import 'package:projeto_slidy/app/modules/home/home_controller.dart';
import 'package:projeto_slidy/app/modules/login/login_module.dart';
import 'package:projeto_slidy/app/shared/widget/menu_lateral/menu_lateral_controller.dart';
import 'package:projeto_slidy/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:projeto_slidy/app/app_widget.dart';
import 'package:projeto_slidy/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MeusagendamentosController()),
        Bind((i) => LoginRepository(i.get<Dio>())),
        Bind((i) => Dio()),
        Bind((i) => AgendamentoRepository(i.get<Dio>())),
        Bind((i) => HorariosdisponiveisController()),
        Bind((i) => AppController()),
        Bind((i) => LoginController(i.get<LoginRepository>())),
        Bind((i) => HomeController(i.get<AgendamentoRepository>())),
        Bind((i) => MenuLateralController()),
        Bind((i) => CriaragendamentoController(i.get<AgendamentoRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: LoginModule()),
        Router('/home', module: HomeModule()),
        Router('/criaragendamento', module: CriaragendamentoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
