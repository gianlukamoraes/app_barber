import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_slidy/app/shared/models/user_model.dart';
import 'package:projeto_slidy/app/shared/repositories/login_repository.dart';
// import 'package:projeto_slidy/app/shared/repositories/login_repository.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  
  final LoginRepository repository;
  
  @observable
  UserModel usuarioLogado;
  @observable
  String username = "";

  @observable
  String password = "";

  @observable
  bool loginOk;

  _LoginControllerBase(this.repository);

  // _LoginControllerBase(this.repository);

  @action
  fazerLogin(UserModel user) async {
      bool isOk = false;
      print("Controller chamando Repo. [$usuarioLogado]");
      this.usuarioLogado = await repository.fazerLogin(user);
      if(usuarioLogado == null){
        loginOkStatus(false);
      }else{
        loginOkStatus(true);
      }
  }
  @action
  loginOkStatus(value){
    this.loginOk = value;
  }
  /*
  inserirLista(ListasModel list) async {
    final Dio dio = Dio();

    
    print(">>>>>>>.. Inserindo Produto ${list.toJson(list)}");
    Response response = await dio.post("http://10.1.1.106:1337/listas",
        data: list.toJson(list),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.data["code"] == 0) {
        // return RetornoApiModel.fromJson(json: response.data);
        print(response.data);
      } else {
        print(response.data);
        // throw new Exception(response.data["message"]);
      }
    } else {
      // throw new Exception("Erro no servidor! Verifique com a TI!");
      print(response.data);
    }

    homecontroller.buscarListas();
  }*/

}
