import 'package:flutter/material.dart';
import 'salary.dart';
import 'homepage.dart';
import 'calendar.dart';
import 'arrangement.dart';
import 'leave.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Clock In",
      home: new HomePage(color: Colors.cyan,),
      routes: <String, WidgetBuilder>{
          "/calender": (context) => CalendarPage(
                title: "Calender",
                color: Colors.cyan,
              ),
           "/arrangement": (context) => ArrangePage(
                title: "Arrangement",
                color: Colors.cyan,
              ),
            "/salary":(context) => SalaryPage(
                title: "Salary ",
                color: Colors.cyan,
            ),
            "/leave": (context) => LeavePage(
                title: "Leave",
                color: Colors.cyan,
              ),
        },
    );
  }
}


