import 'package:mobx/mobx.dart';

part 'horariosdisponiveis_controller.g.dart';

class HorariosdisponiveisController = _HorariosdisponiveisControllerBase
    with _$HorariosdisponiveisController;

abstract class _HorariosdisponiveisControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
