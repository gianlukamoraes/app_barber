import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_slidy/app/app_module.dart';
import 'package:projeto_slidy/app/modules/criaragendamento/criaragendamento_controller.dart';
import 'package:projeto_slidy/app/shared/widget/menu_lateral/menu_lateral_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final controller = AppModule.to.get<HomeController>();
  final agendamentocontroller = AppModule.to.get<CriaragendamentoController>();
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  // Example holidays
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
  };

  @override
  void initState() {
    super.initState();
    agendamentocontroller.buscarCadastroServicos();
    final _selectedDay = DateTime.now();
    controller.buscarAgendamentosDia(_selectedDay);
    print(controller.agendamentos);
    print("SELECTED DAY: $_selectedDay");
    _events = {
      //  controller.buscaAgendamentos()
      //   _selectedDay.subtract(Duration(days: 30)): [
      //     'Event A0',
      //     'Event B0',
      //     'Event C0'
      //   ],
      //   _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      //   _selectedDay.subtract(Duration(days: 20)): [
      //     'Event A2',
      //     'Event B2',
      //     'Event C2',
      //     'Event D2'
      //   ],
      //   _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      //   _selectedDay.subtract(Duration(days: 10)): [
      //     'Event A4',
      //     'Event B4',
      //     'Event C4'
      //   ],
      //   _selectedDay.subtract(Duration(days: 4)): [
      //     'Event A5',
      //     'Event B5',
      //     'Event C5'
      //   ],
      //   _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],

      // _selectedDay: [
      //   '15:00:00-16:00:00 | Cliente: GIANLUKA MORAES DE SOUSA | Barbeiro: THIAGO , 13:00:00-14:00:00 | Cliente: JORDANA MENEGILDO LOPES OLIVEIRA CARVALHO | Barbeiro: JOAO'
      // ]
      // _selectedDay: [],
      //   _selectedDay.add(Duration(days: 1)): [
      //     'Event A8',
      //     'Event B8',
      //     'Event C8',
      //     'Event D8'
      //   ],
      //   _selectedDay.add(Duration(days: 3)):
      //       Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      //   _selectedDay.add(Duration(days: 7)): [
      //     'Event A10',
      //     'Event B10',
      //     'Event C10'
      //   ],
      //   _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      //   _selectedDay.add(Duration(days: 17)): [
      //     'Event A12',
      //     'Event B12',
      //     'Event C12',
      //     'Event D12'
      //   ],
      //   _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      //   _selectedDay.add(Duration(days: 26)): [
      //     'Event A14',
      //     'Event B14',
      //     'Event C14'
      //   ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    //  _animationController = AnimationController(
    //   //  vsync: this,
    //   vsync: ,
    //    duration: const Duration(milliseconds: 400),
    //  );

    //  _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected new');
    controller.buscarAgendamentosDia(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateralWidget(),
      appBar: AppBar(
        title: Text('Manhattan Barber Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Modular.to.popAndPushNamed("/"),
          )
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTableCalendar(),
            _buildAgendamentos(),
          ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // onPressed: _showAddDialog,
        onPressed: () => Modular.to.pushNamed('/criaragendamento'),
      ),
    );
  }

  Widget _buildAgendamentos() {
    return Observer(builder: (_) {
      print(
          "Dentro do Observer ${controller.agendamentos.length} agendamentos");
      if (controller.agendamentos.length > 0) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.agendamentos.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.red,
                    child: Card(
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  controller.agendamentos[index].cliente,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Profissional: ${controller.agendamentos[index].profissional}",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Serviços: ${controller.agendamentos[index].servicos}",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              controller.agendamentos[index].dia,
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              controller.agendamentos[index].hora_inicio,
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.agendamentos[index].hora_final,
                              style: TextStyle(fontSize: 10),
                            ),
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

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      // onDaySelected: _onDaySelected,
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        // _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
      // availableCalendarFormats: const {
      //    CalendarFormat.month: '',
      //    CalendarFormat.twoWeeks: '',
      //  },
      // builders: CalendarBuilders(
      // selectedDayBuilder: (context, date, _) {
      //   return FadeTransition(
      //     opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
      //     child: Container(
      //       margin: const EdgeInsets.all(4.0),
      //       padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      //       color: Colors.deepOrange[300],
      //       width: 100,
      //       height: 100,
      //       child: Text(
      //         '${date.day}',
      //         style: TextStyle().copyWith(fontSize: 16.0),
      //       ),
      //     ),
      //   );
      // },
      // todayDayBuilder: (context, date, _) {
      //   return Container(
      //     margin: const EdgeInsets.all(4.0),
      //     padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      //     color: Colors.amber[400],
      //     width: 100,
      //     height: 100,
      //     child: Text(
      //       '${date.day}',
      //       style: TextStyle().copyWith(fontSize: 16.0),
      //     ),
      //   );
      // },
      //   markersBuilder: (context, date, events, holidays) {
      //     final children = <Widget>[];
      //     print("EVENTSEVENTS -> $events");
      //     if (events.isNotEmpty) {
      //       children.add(
      //         Positioned(
      //           right: 1,
      //           bottom: 1,
      //           child: _buildEventsMarker(date, events),
      //         ),
      //       );
      //     }

      //     // if (holidays.isNotEmpty) {
      //     //   children.add(
      //     //     Positioned(
      //     //       right: -2,
      //     //       top: -2,
      //     //       child: _buildHolidaysMarker(),
      //     //     ),
      //     //   );
      //     // }

      //     return children;
      //   },
      // ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  // Widget _buildTableCalendarWithBuilders() {
  //   return TableCalendar(
  //     // locale: 'pt_BR',
  //     calendarController: _calendarController,
  //     events: _events,
  //     holidays: _holidays,
  //     initialCalendarFormat: CalendarFormat.month,
  //     formatAnimation: FormatAnimation.slide,
  //     startingDayOfWeek: StartingDayOfWeek.sunday,
  //     availableGestures: AvailableGestures.all,
  //     availableCalendarFormats: const {
  //       CalendarFormat.month: '',
  //       CalendarFormat.twoWeeks: '',
  //     },
  //     calendarStyle: CalendarStyle(
  //       outsideDaysVisible: false,
  //       weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
  //       holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
  //     ),
  //     daysOfWeekStyle: DaysOfWeekStyle(
  //       weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
  //     ),
  //     headerStyle: HeaderStyle(
  //       centerHeaderTitle: true,
  //       formatButtonVisible: false,
  //     ),
  //     builders: CalendarBuilders(
  //       selectedDayBuilder: (context, date, _) {
  //         return FadeTransition(
  //           opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
  //           child: Container(
  //             margin: const EdgeInsets.all(4.0),
  //             padding: const EdgeInsets.only(top: 5.0, left: 6.0),
  //             color: Colors.deepOrange[300],
  //             width: 100,
  //             height: 100,
  //             child: Text(
  //               '${date.day}',
  //               style: TextStyle().copyWith(fontSize: 16.0),
  //             ),
  //           ),
  //         );
  //       },
  //       todayDayBuilder: (context, date, _) {
  //         return Container(
  //           margin: const EdgeInsets.all(4.0),
  //           padding: const EdgeInsets.only(top: 5.0, left: 6.0),
  //           color: Colors.amber[400],
  //           width: 100,
  //           height: 100,
  //           child: Text(
  //             '${date.day}',
  //             style: TextStyle().copyWith(fontSize: 16.0),
  //           ),
  //         );
  //       },
  //       markersBuilder: (context, date, events, holidays) {
  //         final children = <Widget>[];

  //         if (events.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               right: 1,
  //               bottom: 1,
  //               child: _buildEventsMarker(date, events),
  //             ),
  //           );
  //         }

  //         if (holidays.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               right: -2,
  //               top: -2,
  //               child: _buildHolidaysMarker(),
  //             ),
  //           );
  //         }

  //         return children;
  //       },
  //     ),
  //     onDaySelected: (date, events) {
  //       print("268 - Date: $date --- events: $events");
  //       _onDaySelected(date, events);
  //       _animationController.forward(from: 0.0);
  //     },
  //     onVisibleDaysChanged: _onVisibleDaysChanged,
  //     onCalendarCreated: _onCalendarCreated,
  //   );
  // }

  // Widget _buildEventsMarker(DateTime date, List events) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     decoration: BoxDecoration(
  //       shape: BoxShape.rectangle,
  //       color: _calendarController.isSelected(date)
  //           ? Colors.brown[500]
  //           : _calendarController.isToday(date)
  //               ? Colors.brown[300]
  //               : Colors.blue[400],
  //     ),
  //     width: 16.0,
  //     height: 16.0,
  //     child: Center(
  //       child: Text(
  //         '${controller.agendamentos.length}',
  //         style: TextStyle().copyWith(
  //           color: Colors.white,
  //           fontSize: 12.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildHolidaysMarker() {
  //   return Icon(
  //     Icons.add_box,
  //     size: 20.0,
  //     color: Colors.blueGrey[800],
  //   );
  // }

  // Widget _buildButtons() {
  //   final dateTime = _events.keys.elementAt(_events.length - 2);

  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           RaisedButton(
  //             child: Text('Ver Mês'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController.setCalendarFormat(CalendarFormat.month);
  //               });
  //             },
  //           ),
  //           RaisedButton(
  //             child: Text('Ver 2 semanas'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController
  //                     .setCalendarFormat(CalendarFormat.twoWeeks);
  //               });
  //             },
  //           ),
  //           RaisedButton(
  //             child: Text('Ver semana'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController.setCalendarFormat(CalendarFormat.week);
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 8.0),
  //       RaisedButton(
  //         child: Text(
  //             'Dia selecionado: ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
  //         onPressed: () {
  //           _calendarController.setSelectedDay(
  //             DateTime(dateTime.year, dateTime.month, dateTime.day),
  //             runCallback: true,
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildEventList() {
  //   return ListView(
  //     children: _selectedEvents
  //         .map((event) => Container(
  //               decoration: BoxDecoration(
  //                 border: Border.all(width: 0.8),
  //                 borderRadius: BorderRadius.circular(12.0),
  //               ),
  //               margin:
  //                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  //               child: ListTile(
  //                 title: Text(event.toString()),
  //                 onTap: () => print('$event tapped!'),
  //               ),
  //             ))
  //         .toList(),
  //   );
  // }

  // _showAddDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             content: TextField(
  //               controller: _eventController,
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text("Save"),
  //                 onPressed: () {
  //                   if (_eventController.text.isEmpty) return;
  //                   if (_events[_controller.selectedDay] != null) {
  //                     _events[_controller.selectedDay]
  //                         .add(_eventController.text);
  //                   } else {
  //                     _events[_controller.selectedDay] = [
  //                       _eventController.text
  //                     ];
  //                   }
  //                   prefs.setString("events", json.encode(encodeMap(_events)));
  //                   _eventController.clear();
  //                   Navigator.pop(context);
  //                 },
  //               )
  //             ],
  //           ));
  //   setState(() {
  //     _selectedEvents = _events[_controller.selectedDay];
  //   });
  // }
}
