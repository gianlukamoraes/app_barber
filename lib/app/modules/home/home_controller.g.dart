// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$agendamentosAtom = Atom(name: '_HomeControllerBase.agendamentos');

  @override
  List<AgendamentoModel> get agendamentos {
    _$agendamentosAtom.context.enforceReadPolicy(_$agendamentosAtom);
    _$agendamentosAtom.reportObserved();
    return super.agendamentos;
  }

  @override
  set agendamentos(List<AgendamentoModel> value) {
    _$agendamentosAtom.context.conditionallyRunInAction(() {
      super.agendamentos = value;
      _$agendamentosAtom.reportChanged();
    }, _$agendamentosAtom, name: '${_$agendamentosAtom.name}_set');
  }

  final _$buscarAgendamentosDiaAsyncAction =
      AsyncAction('buscarAgendamentosDia');

  @override
  Future buscarAgendamentosDia(dynamic dia) {
    return _$buscarAgendamentosDiaAsyncAction
        .run(() => super.buscarAgendamentosDia(dia));
  }

  @override
  String toString() {
    final string = 'agendamentos: ${agendamentos.toString()}';
    return '{$string}';
  }
}
