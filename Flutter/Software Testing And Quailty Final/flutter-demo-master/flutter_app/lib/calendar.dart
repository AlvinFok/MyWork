import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';
import 'package:flutter_custom_calendar/style/style.dart';
import 'package:random_pk/random_pk.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _CalendarPage createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  ValueNotifier<String> text;
  ValueNotifier<String> selectText;

  CalendarController controller;

  Map<DateModel, String> customExtraData = {
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -1))): "假",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -2))): "游",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -3))): "事", 
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -4))): "班",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -5))): "假",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -6))): "游",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -7))): "事",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: -8))): "班",
    DateModel.fromDateTime(DateTime.now()): "假",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 1))): "假",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 2))): "游",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 3))): "事",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 4))): "班",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 5))): "假",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 6))): "游",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 7))): "事",
    DateModel.fromDateTime(DateTime.now().add(Duration(days: 8))): "班",
  };

  @override
  void initState() {
    super.initState();
    controller = new CalendarController(
        selectDateModel: DateModel.fromDateTime(DateTime.now()),
        extraDataMap: customExtraData);

    controller.addMonthChangeListener(
      (year, month) {
        text.value = "$year/$month";
      },
    );
    controller.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      
      selectText.value =
          "${DateFormat('yyyy-MM-dd').format(controller.getSingleSelectCalendar().getDateTime())}";
    });

    text = new ValueNotifier("${DateTime.now().year}/${DateTime.now().month}");

    selectText = new ValueNotifier(
        "${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: widget.color.withOpacity(.5),
        appBar: new AppBar(
          backgroundColor: widget.color,
        elevation: 0,
        title: Text(widget.title),
        
      ),
      body: new Container(
        
        
        
        child: new Column(
          children: <Widget>[
            new Container(
              color: Colors.white,
              
              child: Column(
                children: <Widget>[
                  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: () {
                      controller.moveToPreviousMonth();
                    }),
                SizedBox(width: 20,),
                ValueListenableBuilder(
                    valueListenable: text,
                    builder: (context, value, child) {
                      return new Text(text.value);
                    }),
                SizedBox(width: 20,),
                new IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      controller.moveToNextMonth();
                    }),
              ],
            ),
            CalendarViewWidget(
              calendarController: controller,
              weekBarItemWidgetBuilder: () {
                return CustomStyleWeekBarItem();
              },
              dayWidgetBuilder: (dateModel) {
                return CustomStyleDayWidget(dateModel);
              },
            ),
                ]
              ),
              
            ),
            Expanded(
              child:ValueListenableBuilder(
                valueListenable: selectText,
                builder: (context, value, child) {
                  return new Container(
                    height: 180,
                    child:new ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.black,
                          ),
                      itemCount: 10,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(child: Text("${selectText.value} : index ${index+1}")),
                          ),
                    ),
                  );
                })
            ),
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/arrangement");
          //controller.toggleExpandStatus();
          //controller.changeExtraData({});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    )
    
    );
  }
}

class CustomStyleWeekBarItem extends BaseWeekBar {
  final List<String> weekList = ["Mon", "Tue", "Web", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget getWeekBarItem(int index) {
    return new Container(
      child: new Center(
        child: new Text(weekList[index]),
      ),
    );
  }
}

class CustomStyleDayWidget extends BaseCombineDayWidget {
  CustomStyleDayWidget(DateModel dateModel) : super(dateModel);

  @override
  Widget getNormalWidget(DateModel dateModel) {
    if (!dateModel.isCurrentMonth) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.all(8),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column( 
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //公历
              new Expanded(
                child: Center(
                  child: new Text(
                    dateModel.day.toString(),
                    style: currentMonthTextStyle,
                  ),
                ),
              ),
            ],
          ),
          dateModel.extraData != null
              ? Positioned(
                  child: Text(
                    "${dateModel.extraData}",
                    style: TextStyle(fontSize: 10, color: RandomColor.next()),
                  ),
                  right: 0,
                  top: 0,
                )
              : Container()
        ],
      ),
    );
  }

  @override
  Widget getSelectedWidget(DateModel dateModel) {
    if (!dateModel.isCurrentMonth) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.all(8),
      foregroundDecoration:
          new BoxDecoration(border: Border.all(width: 2, color: Colors.blue)),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //公历
              new Expanded(
                child: Center(
                  child: new Text(
                    dateModel.day.toString(),
                    style: currentMonthTextStyle,
                  ),
                ),
              ),

            ],
          ),
          dateModel.extraData != null
              ? Positioned(
                  child: Text(
                    "${dateModel.extraData}",
                    style: TextStyle(fontSize: 10, color: RandomColor.next()),
                  ),
                  right: 0,
                  top: 0,
                )
              : Container()
        ],
      ),
    );
  }
}