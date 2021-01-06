import 'package:flutter/material.dart';


class LeavePage extends StatefulWidget {
  LeavePage({Key key, this.title,this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _LeavePage createState() => new _LeavePage();
}

class _LeavePage extends State<LeavePage> {


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
        ),
        
        body:new Column(
          children: [
            Container(
              height: 200,
              color: Colors.white,
            ),
          ],
        )
      )
    );    
  }
}

