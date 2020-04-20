import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:projeto_slidy/app/app_module.dart';
import 'package:projeto_slidy/app/modules/login/login_controller.dart';
import 'package:projeto_slidy/app/shared/models/user_model.dart';

class LoginRepository extends Disposable {
  final Dio dio;

  LoginRepository(this.dio);
  

  Future<UserModel> fazerLogin(UserModel login) async {
    final response = await dio.post("http://10.1.1.106:3030/usuarios/entrar",
        data: login.toJson(login),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
    // print("RESPONSE.DATA -> ${response.data}");
    if (response.data["valid"]) {
      // logincontroller.loginOkStatus(true);
      var items = response.data['dadosUser'];
      print(items);
      UserModel userLogado = UserModel.fromJson(items[0]);
      return userLogado;
    }else{
      // logincontroller.loginOkStatus(false);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
