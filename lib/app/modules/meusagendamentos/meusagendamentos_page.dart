import 'package:flutter/material.dart';

class MeusagendamentosPage extends StatefulWidget {
  final String title;
  const MeusagendamentosPage({Key key, this.title = "Meusagendamentos"})
      : super(key: key);

  @override
  _MeusagendamentosPageState createState() => _MeusagendamentosPageState();
}

class _MeusagendamentosPageState extends State<MeusagendamentosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
