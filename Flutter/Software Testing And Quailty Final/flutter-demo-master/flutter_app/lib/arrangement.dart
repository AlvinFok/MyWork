import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ArrangePage extends StatefulWidget {
  ArrangePage({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _ArrangePage createState() => new _ArrangePage();
}


class _ArrangePage extends State<ArrangePage> {
  DateTime _dateTime;
  bool btnDate = false;

  final _title = TextEditingController();
  final _detail = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _detail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
  }

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
              icon: new Icon(Icons.add),
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text("Title: "+_title.text+"\nDate :"+DateFormat('yyyy-MM-dd HH:mm').format(_dateTime)+"\nDetail: "+_detail.text),
                    );
                  },
                );
              },
            ),
          ]
        ),
        
        body:new Container(
            child: SingleChildScrollView( 
              child:new Column(
                children: <Widget>[
                  _titleText(),
                  _dateInput(),
                  _detailText()
                ]) 
          )
          )
      )
    );   
  }

Widget _titleText(){
  return Container(
    color: Colors.white,
    margin: EdgeInsets.only(top:10),
    padding: EdgeInsets.only(left: 20,right: 20,bottom:20.0,top: 5),
    
    child: TextField(
      key: Key('title'),
      decoration: const InputDecoration(
        hintText: 'Title',
      ),
      controller: _title,
    ),
  );
}

Widget _dateInput(){
  return Container(
    height: btnDate? 210: 75,
    color: Colors.white,
    margin: EdgeInsets.only(top:10),
    padding: EdgeInsets.only(left: 20,right: 20,bottom:20.0,top: 5),
    child: new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            
            Text("Date :",style: new TextStyle(fontSize: 20),),
            SizedBox(width: 20,),
            FloatingActionButton.extended(
              key:Key('date input'),
              label: Text(DateFormat('yyyy-MM-dd HH:mm').format(_dateTime),style: new TextStyle(fontSize: 20,color: Colors.black),),
              backgroundColor: Colors.transparent,
              highlightElevation: 0,
              elevation: 0,
              onPressed: (){
                setState(() {
                  btnDate = btnDate? false: true;
                });
              })
            
          ],
        ),
        SizedBox(height:btnDate? 10: 0),
        new Visibility(
          visible: btnDate,
          child :
        new SizedBox(
          height:120,
          child: new CupertinoDatePicker(
          initialDateTime: _dateTime,
          mode: CupertinoDatePickerMode.dateAndTime,
          use24hFormat: true,
          onDateTimeChanged: (dateTime){
            setState(() {
              _dateTime = dateTime;
            });
          },
          ),
        ),)
    ]
        )
      );
}

Widget _detailText() {
  return Container(
    height: 200,
    color: Colors.white,
    margin: EdgeInsets.only(top:10),
    padding: EdgeInsets.only(left: 20,right: 20,bottom:20.0,top: 5),
    
    child: TextField(
      decoration: const InputDecoration(
        hintText: 'Detail',
      ),
      maxLines : 10,
      controller: _detail,
    ),
  );
  }


}

