import 'package:mobx/mobx.dart';

part 'meusagendamentos_controller.g.dart';

class MeusagendamentosController = _MeusagendamentosControllerBase
    with _$MeusagendamentosController;

abstract class _MeusagendamentosControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
