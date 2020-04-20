import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:projeto_slidy/app/app_module.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/criaragendamento_controller.dart';
import 'package:projeto_slidy/app/shared/models/profissional_model.dart';
import 'package:projeto_slidy/app/shared/utils/color_app.dart';
import 'package:steps/steps.dart';

class CriaragendamentoPage extends StatefulWidget {
  final String title;
  const CriaragendamentoPage({Key key, this.title = "Criaragendamento"})
      : super(key: key);

  @override
  _CriaragendamentoPageState createState() => _CriaragendamentoPageState();
}

class _CriaragendamentoPageState extends State<CriaragendamentoPage> {
  final controller = AppModule.to.get<CriaragendamentoController>();

  bool step1 = false;
  bool step2 = false;
  bool step3 = false;
  bool step4 = false;
  bool step5 = false;

  String dropdownValue = 'Selecione';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate,
        firstDate: DateTime(2015, 8),
        locale: Locale('pt'),
        lastDate: DateTime(2101));
    if (picked != null && picked != controller.selectedDate) {
      controller.atualizaSelectedDate(picked);
    }
  }

  @override
  void initState() {
    controller.buscarProfissionais();
    controller.buscarCadastroServicos();
    controller.tempoServicos = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Agendamento"),
        actions: [
          Observer(
            builder: (_) {
              return IconButton(
                icon: Icon(
                  Icons.save,
                ),
                onPressed: () {
                  if (_validacao()) {
                    controller.incluirAgendamento();

                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        btnOkColor: Colors.blue,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'Novo Agendamento',
                        desc:
                            'Seu horário foi agendado com sucesso! Agradecemos a Preferência.',
                        btnOkOnPress: () {
                          Modular.to.pushNamedAndRemoveUntil(
                              "/home", (route) => false);
                        }).show();

                    // Modular.to.pushNamed("/criaragendamento/horariosdisponiveis");
                  }
                },
              );
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Steps(
          direction: Axis.vertical,
          size: 20.0,
          path: {'color': Colors.black, 'width': 3.0},
          steps: [
            {
              'color': Colors.white,
              'background': Colors.black,
              'label': '1',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Escolha um Profissional:',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  Observer(
                    builder: (_) {
                      return DropdownButton<String>(
                        value: controller.profissional,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.pink),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          print(
                              "Profissionais -> ${controller.listaProfissionais}");
                          controller.selecionaProfissional(newValue);
                        },
                        items: controller.listaProfissionais
                            .map((ProfissionalModel profissional) {
                          return DropdownMenuItem<String>(
                            value: profissional.id.toString(),
                            child: Text(
                              profissional.nome,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            },
            {
              'color': Colors.white,
              'background': Colors.black,
              'label': '2',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Escolha os Serviços:',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  Container(
                      height: controller.listaServicos.length * 80.0,
                      width: MediaQuery.of(context).size.width * .7,
                      child: Observer(builder: (_) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _checkBoxServicos(),
                            ]);
                      }))
                ],
              )
            },
            {
              'color': Colors.white,
              'background': Colors.black,
              'label': '3',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Escolha uma Data:',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Data Selecionada:"),
                  Observer(builder: (_) {
                    // return Text("${controller.selectedDate}".split(' ')[0]);
                    return Text(
                        "Data: ${formatDateTime(controller.selectedDate)}");
                  }),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: colorapp,
                    onPressed: () => _selectDate(context),
                    child: Text('Selecione uma data'),
                  ),
                ],
              ),
            },
            {
              'color': Colors.white,
              'background': Colors.black,
              'label': '4',
              'content': Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Escolha um Horário:',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Duração: ${controller.tempoServicos} minutos"),
                  Observer(builder: (_) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Horário Escolhido: ${formatTimeOfDay(controller.selectedTime)}"),
                      ],
                    );
                    // return Text("Horário selecionado: ${controller.selectedTime}");
                  }),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: colorapp,
                    onPressed: () {
                      print("_pickTime");
                      _pickTime();
                    },
                    child: Text('Que hora voce vai chegar ?'),
                  ),
                ],
              ),
            },
          ],
        ),
      ),
    );
  }

  Widget _checkBoxServicos() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.listaServicos.length,
        itemBuilder: (context, index) {
          return Observer(builder: (_) {
            return CheckboxListTile(
                subtitle: Text(
                  "Tempo Aprox.: ${controller.listaServicos[index].duracao} minutos.",
                  style: TextStyle(fontSize: 12),
                ),
                title: Text(controller.listaServicos[index].nome),
                value: controller.listaServicos[index].checkbox,
                onChanged: (value) {
                  print("Value: $value");
                  print(
                      "CheckBox: ${controller.listaServicos[index].checkbox}");
                  print(controller.listaServicos[index].nome);
                  setState(() {
                    controller.checkboxAgendamento(index, value);
                  });
                });
          });
        },
      ),
    );
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
        context: context, initialTime: controller.selectedTime);
    if (t != null) controller.atualizaSelectedTime(t);
  }

  _validacao() {
    bool isOk = true;
    bool servicesOk = false;

    if (controller.profissional.isEmpty ||
        controller.profissional == "Selecione") {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              btnOkColor: Colors.blue,
              animType: AnimType.BOTTOMSLIDE,
              tittle: 'Profissional',
              desc: 'Selecione o Profissional que irá lhe atender!',
              btnOkOnPress: () {})
          .show();
      isOk = false;
    }

    if (isOk) {
      controller.listaServicos.forEach((value) {
        if (value.checkbox && !servicesOk) {
          servicesOk = true;
        }
      });

      if (!servicesOk) {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                btnOkColor: Colors.blue,
                animType: AnimType.BOTTOMSLIDE,
                tittle: 'Serviços',
                desc: 'Selecione pelo menos um serviço!',
                btnOkOnPress: () {})
            .show();
      }
    }

    return isOk;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm(); //"6:00 AM"
    return format.format(dt);
  }

  String formatDateTime(DateTime date) {
    final now = new DateTime.now();
    final dt = DateTime(date.year, date.month, date.day, now.hour, now.minute);
    final format = DateFormat.yMd();
    return format.format(dt);
  }
}
