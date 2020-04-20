import 'package:mobx/mobx.dart';

part 'verhorarios_controller.g.dart';

class VerhorariosController = _VerhorariosControllerBase
    with _$VerhorariosController;

abstract class _VerhorariosControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
