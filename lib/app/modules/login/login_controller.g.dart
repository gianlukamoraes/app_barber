// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$usuarioLogadoAtom = Atom(name: '_LoginControllerBase.usuarioLogado');

  @override
  UserModel get usuarioLogado {
    _$usuarioLogadoAtom.context.enforceReadPolicy(_$usuarioLogadoAtom);
    _$usuarioLogadoAtom.reportObserved();
    return super.usuarioLogado;
  }

  @override
  set usuarioLogado(UserModel value) {
    _$usuarioLogadoAtom.context.conditionallyRunInAction(() {
      super.usuarioLogado = value;
      _$usuarioLogadoAtom.reportChanged();
    }, _$usuarioLogadoAtom, name: '${_$usuarioLogadoAtom.name}_set');
  }

  final _$usernameAtom = Atom(name: '_LoginControllerBase.username');

  @override
  String get username {
    _$usernameAtom.context.enforceReadPolicy(_$usernameAtom);
    _$usernameAtom.reportObserved();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.context.conditionallyRunInAction(() {
      super.username = value;
      _$usernameAtom.reportChanged();
    }, _$usernameAtom, name: '${_$usernameAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_LoginControllerBase.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$loginOkAtom = Atom(name: '_LoginControllerBase.loginOk');

  @override
  bool get loginOk {
    _$loginOkAtom.context.enforceReadPolicy(_$loginOkAtom);
    _$loginOkAtom.reportObserved();
    return super.loginOk;
  }

  @override
  set loginOk(bool value) {
    _$loginOkAtom.context.conditionallyRunInAction(() {
      super.loginOk = value;
      _$loginOkAtom.reportChanged();
    }, _$loginOkAtom, name: '${_$loginOkAtom.name}_set');
  }

  final _$fazerLoginAsyncAction = AsyncAction('fazerLogin');

  @override
  Future fazerLogin(UserModel user) {
    return _$fazerLoginAsyncAction.run(() => super.fazerLogin(user));
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic loginOkStatus(dynamic value) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.loginOkStatus(value);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'usuarioLogado: ${usuarioLogado.toString()},username: ${username.toString()},password: ${password.toString()},loginOk: ${loginOk.toString()}';
    return '{$string}';
  }
}
