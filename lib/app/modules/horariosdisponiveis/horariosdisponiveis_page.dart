import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class HorariosdisponiveisPage extends StatefulWidget {
  final String title;
  const HorariosdisponiveisPage({Key key, this.title = "Horariosdisponiveis"})
      : super(key: key);

  @override
  _HorariosdisponiveisPageState createState() =>
      _HorariosdisponiveisPageState();
}

class _HorariosdisponiveisPageState extends State<HorariosdisponiveisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text("")  ,
    );
  }
}
