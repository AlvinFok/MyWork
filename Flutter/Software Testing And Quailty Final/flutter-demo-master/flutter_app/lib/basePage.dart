import 'package:flutter/material.dart';


class BasePage extends StatefulWidget {
  BasePage({Key key, this.title,this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _BasePage createState() => new _BasePage();
}

class _BasePage extends State<BasePage> {


  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Scaffold(
        backgroundColor: widget.color.withOpacity(.5),
        appBar: new AppBar(
          backgroundColor: widget.color,
          elevation: 0,
          centerTitle: true,
          title: Text(widget.title),
          actions: <Widget>[
            new IconButton( // action button
              icon: new Icon(Icons.settings),
              onPressed: () { print("press setting btn");},
            ),
          ]
        ),
        
        body:new Column(

        )
      )
    );    
  }
}

