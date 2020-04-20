import 'package:projeto_slidy/app/modules/criaragendamento/verhorarios/verhorarios_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/criaragendamento_page.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/verhorarios/verhorarios_page.dart';
import 'package:projeto_slidy/app/modules/horariosdisponiveis/horariosdisponiveis_page.dart';

class CriaragendamentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => VerhorariosController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => CriaragendamentoPage()),
        Router('/horariosdisponiveis',
            child: (_, args) => VerhorariosPage()),
      ];

  static Inject get to => Inject<CriaragendamentoModule>.of();
}
