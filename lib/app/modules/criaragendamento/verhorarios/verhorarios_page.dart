import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_slidy/app/app_module.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/criaragendamento_controller.dart';
import 'package:projeto_slidy/app/modules/home/home_controller.dart';

class VerhorariosPage extends StatefulWidget {
  final String title;
  const VerhorariosPage({Key key, this.title = "Verhorarios"})
      : super(key: key);

  @override
  _VerhorariosPageState createState() => _VerhorariosPageState();
}

class _VerhorariosPageState extends State<VerhorariosPage> {
  final homecontroller = AppModule.to.get<HomeController>();
  final agendamentocontroller = AppModule.to.get<CriaragendamentoController>();

  @override
  void initState() {
    homecontroller.buscarAgendamentosDia(agendamentocontroller.selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Column(children: [
              Text("Hora Escolhida: ${agendamentocontroller.selectedTime.toString()}"),
            ]),
          ),
          Text(
            "HORARIOS NAO DISPONIVEIS:",
            style: TextStyle(fontSize: 20),
          ),
          _buildAgendamentos(),
        ],
      ),
    );
  }

  Widget _buildAgendamentos() {
    return Observer(builder: (_) {
      print(
          "Dentro do Observer ${homecontroller.agendamentos.length} agendamentos");
      if (homecontroller.agendamentos.length > 0) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: homecontroller.agendamentos.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    // color: Colors.red,
                    child: Card(
                      child: Center(
                        child: ListTile(
                          title: Column(
                            children: [
                              Text(
                                "Horário Indisponível",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Profissional: ${homecontroller.agendamentos[index].profissional}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          leading: Column(
                            children: <Widget>[
                              Text(homecontroller
                                  .agendamentos[index].hora_inicio),
                              SizedBox(
                                height: 10,
                              ),
                              Text(homecontroller
                                  .agendamentos[index].hora_final),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Icon(Icons.add),
                              Icon(Icons.add_a_photo),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      } else {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Text("Sem Agendamento"),
        );
      }
    });
  }
}
