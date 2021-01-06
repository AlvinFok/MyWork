import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalaryPage extends StatefulWidget {
  SalaryPage({Key key, this.title,this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _SalaryPage createState() => new _SalaryPage();
}

class UserData {
  final int id;
  final String date;
  final String start;
  final String end;
  final int money;

  UserData({this.id,this.date,this.start,this.end,this.money});
}

class _SalaryPage extends State<SalaryPage> {
  var _userData = <UserData>[];
  DateTime _dateTime ;

  @override
  void initState() {
    _dateTime = new DateTime(DateTime.now().year,DateTime.now().month,01);
    _userData = [
      UserData(id:1,date:"2020-06-10",start:"11:00:00",end:"19:30:20",money:160),
      UserData(id:2,date:"2020-06-11",start:"12:00:00",end:"20:30:20",money:260),
      UserData(id:3,date:"2020-06-12",start:"10:00:00",end:"14:30:20",money:360),
      UserData(id:4,date:"2020-06-13",start:"09:00:00",end:"17:30:20",money:460),
      UserData(id:5,date:"2020-06-14",start:"12:00:00",end:"21:30:20",money:560),
      UserData(id:6,date:"2020-06-15",start:"17:00:00",end:"21:30:20",money:660),
      UserData(id:7,date:"2020-06-15",start:"17:00:00",end:"21:30:20",money:760),
      UserData(id:8,date:"2020-06-15",start:"17:00:00",end:"21:30:20",money:860),
      UserData(id:9,date:"2020-06-15",start:"17:00:00",end:"21:30:20",money:960),
      UserData(id:10,date:"2020-06-15",start:"17:00:00",end:"21:30:20",money:1060),
      ];
    super.initState();
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
          
        ),
        
        body: Container(
          padding: EdgeInsets.all(10),
          child : new Column(
          children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.navigate_before,size: 40,),
                  onPressed: () {
                    setState(() {
                      _dateTime = new DateTime(_dateTime.year,_dateTime.month-1,01);
                    });
                  }),
              new Text(DateFormat('MM-yyyy').format(_dateTime),style: new TextStyle(fontSize: 20,fontFamily: "Aldrich",height:2),),
              new IconButton(
                  icon: Icon(Icons.navigate_next,size: 40,),
                  onPressed: () {
                    setState(() {
                       _dateTime = new DateTime(_dateTime.year,_dateTime.month+1,01);
                    });
                  }),
            ],
          ),
          SizedBox(height:10),
          new Container(
            padding: EdgeInsets.all(10),
            height: 400,
            color: Colors.white,
            child: SingleChildScrollView(
                  child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: Text("Date"),),
                        DataColumn(label: Text("time"),),
                        DataColumn(label: Text("Money"),),                    
                      ],
                      rows: _userData.map((userData)=>DataRow(
                          cells: [
                            DataCell(
                              Text("${userData.date}"),
                              showEditIcon: false,
                              placeholder: false
                            ),
                            DataCell(
                              Container(width:120,child:Text("${userData.start} - ${userData.end}"))
                              ,
                              showEditIcon: false,
                              placeholder: false
                            ),
                            DataCell(
                              Text("\$${userData.money}"),
                              showEditIcon: false,
                              placeholder: false
                            ), 
                          ]
                        )).toList()
                  ),
              )
          ),
          SizedBox(height:20),
          Container(
            child: Row(
              children: [
                Text("Total :", style: new TextStyle(fontSize: 40,fontFamily: "Aldrich"),),
                Spacer(),
                Text("\$${ _userData.map((u)=> u.money).reduce((value, element) => value + element)}", style: new TextStyle(fontSize: 40,fontFamily: "Aldrich"),)
              ],
            ),
          ),
          

        ]
        )
        )
      )
    );    
  }
}

