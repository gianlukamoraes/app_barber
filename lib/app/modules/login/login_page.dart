import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_slidy/app/app_module.dart';
import 'package:projeto_slidy/app/modules/login/login_controller.dart';
import 'package:projeto_slidy/app/shared/models/user_model.dart';
import 'package:projeto_slidy/app/shared/widget/animation/fade_animation.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final controller = AppModule.to.get<LoginController>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // body: SingleChildScrollView(
      // child: Container(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        // image: AssetImage('assets/images/background.png'),
                        image: AssetImage('assets/images/pole.gif'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          )),
                    ),
                    Positioned(
                      left: 40,
                      top: 200,
                      width: 200,
                      height: 200,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/logo_manhattan.png'))),
                          )),
                    ),
                    Positioned(
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: ListTile(
                                  trailing: Icon(Icons.phone),
                                  title: TextField(
                                      textInputAction: TextInputAction.go,
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email or Phone number",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]))),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: ListTile(
                                  trailing: IconButton(
                                    icon: _obscureText
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      _toggle();
                                    },
                                  ),
                                  title: TextField(
                                      textInputAction: TextInputAction.go,
                                      controller: passwordController,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]))),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      Observer(builder: (_) {
                        return InkWell(
                          onTap: () {
                            _entrar();
                            // print(
                            // "LoginPage: LoginOK -> ${controller.loginOk}");
                            // if (!controller.loginOk) {}
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(255, 223, 0, 1),
                                  Color.fromRGBO(255, 223, 0, .6),
                                  // Color.fromRGBO(143, 148, 251, 1),
                                  // Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    FadeAnimation(
                        1.5,
                        Text(
                          "Esqueceu sua senha?",
                          style: TextStyle(
                              // color: Color.fromRGBO(143, 148, 251, 1)),
                              color: Color.fromRGBO(255, 223, 0, 1)),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // )
    );
  }

  _entrar() async {
    try {
      await controller.fazerLogin(UserModel(
        email: usernameController.text.toLowerCase().trim(),
        senha: passwordController.text.trim(),
      ));
    } on Exception catch (erro) {
      print(erro);
    }

    if (controller.usuarioLogado != null) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.TOPSLIDE,
          tittle: 'Bem-Vindo',
          desc: 'Login efetuado com sucesso.',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            Modular.to.popAndPushNamed("/home");
          }).show();
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              btnOkColor: Colors.red,
              animType: AnimType.BOTTOMSLIDE,
              tittle: 'Acesso Negado',
              desc: 'Verifique se seu e-mail e/ou senha estão corretos.',
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
  }
}
