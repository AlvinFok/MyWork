import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class Server {
  double getTotalHoursOfThisMonth() {
    return 1.0;
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.color}) : super(key: key);

  final Color color;
  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hoursStr = (hours % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  Server server;
  void setServer(Server server){
    this.server = server;
  }
  bool isOT() {
    double totalHoursOfThisMonth = server.getTotalHoursOfThisMonth();
    //debugPrint("Total Hours of this month: ${totalHoursOfThisMonth}");
    if (totalHoursOfThisMonth > 250) {
      return true;
    }
    return false;
  }

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  Stopwatch watch = new Stopwatch();
  Timer timer;
  final Duration duration = const Duration(milliseconds: 300);
  double screenWidth, screenHeight;
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String elapsedTime = '00:00:00';
  String startTime = '';
  String endTime = '';
  bool btnStart = true;
  bool btnOut = false;
  bool btnSet = false;

  var menuList = [
    ["Calendar", "/calender"],
    ["Salary", "/salary"],
    ["Day off", "/leave"]
  ];
  List<IconData> iconList = [
    Icons.calendar_today,
    Icons.attach_money,
    Icons.airline_seat_individual_suite
  ];

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return new Container(
        color: Colors.white,
        child: new Scaffold(
            backgroundColor: widget.color.withOpacity(.5),
            appBar: new AppBar(
                backgroundColor: widget.color,
                elevation: 0,
                centerTitle: true,
                title: new Text('CLOCK IN'),
                actions: <Widget>[
                  new IconButton(
                    // action button
                    icon: new Icon(Icons.settings),
                    onPressed: () {
                      setState(() {
                        if (!btnSet) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        btnSet = !btnSet;
                      });
                    },
                  ),
                ]),
            body: Stack(
                children: <Widget>[setting(context), dashboard(context)])));
  }

  Widget setting(context) {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Align(
            alignment: Alignment.centerRight,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Theme color :"),
                  SizedBox(height: 20),
                  Text("testing 1 :"),
                  SizedBox(height: 20),
                  Text("testing 2 :"),
                  SizedBox(height: 20),
                  FloatingActionButton.extended(
                    onPressed: () {
                      print("testing");
                    },
                    label: Text("Logout"),
                    icon: Icon(Icons.power_settings_new),
                  )
                ])));
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: btnSet ? -0.4 * screenWidth : 0,
        right: btnSet ? 0.4 * screenWidth : 0,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
              animationDuration: duration,
              borderRadius: BorderRadius.all(Radius.circular(btnSet ? 40 : 0)),
              elevation: 8,
              color: Colors.white,
              child: Material(
                animationDuration: duration,
                color: widget.color.withOpacity(.5),
                borderRadius:
                    BorderRadius.all(Radius.circular(btnSet ? 40 : 0)),
                child: Column(children: <Widget>[_timer(), _menu()]),
              )),
        ));
  }

  Widget _timer() {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        decoration: BoxDecoration(
          // design style
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 7, //阴影范围
              spreadRadius: 0.5, //阴影浓度
              color: Colors.black54, //阴影颜色
            ),
          ],
        ),
        child: new Column(
          children: <Widget>[
            new Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.timer,
                          size: 25,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                          text: "TIME TRACKING",
                          style: new TextStyle(
                            color: Colors.black54,
                            fontSize: 25.0,
                            fontFamily: "Aldrich",
                          )),
                    ],
                  ),
                )),
            new Visibility(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(btnOut ? elapsedTime.substring(0, 2) : "",
                      style: new TextStyle(
                        fontSize: 45.0,
                        fontFamily: "Aldrich",
                        letterSpacing: -1.5,
                        color: Colors.black54,
                      )),
                  new Text("HR ",
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Aldrich",
                        height: 1.5,
                        color: Colors.black54,
                      )),
                  new Text(btnOut ? elapsedTime.substring(3, 5) : "",
                      style: new TextStyle(
                        fontSize: 45.0,
                        fontFamily: "Aldrich",
                        letterSpacing: -1.5,
                        color: Colors.black54,
                      )),
                  new Text("MIN ",
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Aldrich",
                        height: 1.5,
                        color: Colors.black54,
                      )),
                  new Text(btnOut ? elapsedTime.substring(6) : "",
                      style: new TextStyle(
                        fontSize: 45.0,
                        fontFamily: "Aldrich",
                        letterSpacing: -1.5,
                        color: Colors.black54,
                      )),
                  new Text("SEC ",
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Aldrich",
                        height: 1.5,
                        color: Colors.black54,
                      )),
                ],
              ),
              visible: btnOut,
            ),
            new SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FloatingActionButton.extended(
                    heroTag: "btn_home_startTime",
                    backgroundColor:
                        btnStart ? Colors.green : Colors.yellow[800],
                    onPressed: () {
                      multWatch();
                    },
                    label: Text(btnStart ? "Clock In" : "Pause"),
                    icon: Icon(btnStart ? Icons.play_arrow : Icons.pause)),
                SizedBox(width: 20.0),
                new Visibility(
                    child: FloatingActionButton.extended(
                      heroTag: "btn_home_endTime",
                      backgroundColor: Colors.red,
                      onPressed: () {
                        endWatch();
                      },
                      label: Text("Clock Out"),
                      icon: Icon(Icons.stop),
                    ),
                    visible: btnOut),
              ],
            ),
            new Text(startTime + "   " + endTime,
                style: new TextStyle(fontSize: 15.0)),
          ],
        ));
  }

  Widget _menu() {
    return new Container(
      height: btnOut ? 300 : 340,
      child: new GridView.count(
        crossAxisCount: 3,
        children: List.generate(menuList.length, (index) {
          return Center(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              height: 140,
              width: 140.0,
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: 100,
                    height: 90,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7, //阴影范围
                          spreadRadius: 0.5, //阴影浓度
                          color: Colors.black54, //阴影颜色
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: new FloatingActionButton(
                      backgroundColor: Colors.white,
                      heroTag: "btn_home_$index",
                      child: Icon(
                        iconList[index],
                        size: 50,
                        color: Colors.black54,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, menuList[index][1]);
                      },
                    ),
                  ),
                  new Text(
                    menuList[index][0],
                    style: new TextStyle(
                        fontSize: 20,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  multWatch() {
    if (btnStart) {
      watch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 100), updateTime);
      setState(() {
        startTime = btnOut
            ? startTime
            : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        btnStart = false;
        btnOut = true;
      });
    } else {
      var timeSoFar = watch.elapsedMilliseconds;
      setState(() {
        elapsedTime = transformMilliSeconds(timeSoFar);
        btnStart = true;
      });
      watch.stop();
    }
  }

  endWatch() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
      btnStart = true;
      btnOut = false;
      endTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      elapsedTime = '00:00:00';
    });
    watch.stop();
    watch.reset();
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hoursStr = (hours % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
