import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

int _count = 0;

class MyApp extends StatefulWidget {
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<MyApp> {
  void _increase() {
    setState(() => _count++);
}
  void _reset() {
    setState(() => _count=0);
}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hello World App',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('test'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Up Votes : $_count",
                style: new TextStyle(
                  fontSize:50,
                  ),
              ),
              new RaisedButton(
                child: new Text('Vote up', style: new TextStyle(fontSize: 20.0,)),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                elevation: 10.0,
                splashColor: Colors.white70,
                onPressed: _increase,
              ),
              new RaisedButton(
                child: new Text('reset', style: new TextStyle(fontSize: 20.0,)),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                elevation: 10.0,
                splashColor: Colors.white70,
                onPressed: _reset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
