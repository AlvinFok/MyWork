import 'package:flutter_app/CalTime.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCalTime extends Mock implements FTServer{}

void main() {

  test('CalTime would return 3hr in 17:00 ~ 20:00.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:00:00");
    expect(cal.calHr(StartTime,EndTime), 3);
  });

  test('CalTime would return 9hr in 17:00 ~ 20:00.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 11:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:00:00");
    expect(cal.calHr(StartTime,EndTime), 9.0);
  });

  test('CalTime would return 9hr in 01:00 ~ 20:00.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 01:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:00:00");
    expect(cal.calHr(StartTime,EndTime), 19.0);
  });

  test('CalTime would return 25hr in 18:00 ~ 19:00.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 18:00:00");
    var EndTime = DateTime.parse("2020-06-21 19:00:00");
    expect(cal.calHr(StartTime,EndTime), 25);
  });

  test('CalTime would return 3.25hr in 17:00 ~ 20:15.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:15:00");
    expect(cal.calHr(StartTime,EndTime), 3.25);
  });

  test('CalTime would return 3.5hr in 17:00 ~ 20:30.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:30:00");
    expect(cal.calHr(StartTime,EndTime), 3.5);
  });

  test('CalTime would return 3.75hr in 17:00 ~ 20:45.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:45:00");
    expect(cal.calHr(StartTime,EndTime), 3.75);
  });

  test('CalTime would return 3.33hr in 17:00 ~ 20:20.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:20:00");
    expect(cal.calHr(StartTime,EndTime), 3.33);
  });

  test('CalTime would return 3.67hr in 17:00 ~ 20:40.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:40:00");
    expect(cal.calHr(StartTime,EndTime), 3.67);
  });

  test('CalTime would return 0hr in 17:00 ~ 15:00.', () {
    CalTime cal = new CalTime();
    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 15:00:00");
    expect(cal.calHr(StartTime,EndTime), 0);
  });

  test('Cal salary would return 28hr * 158 = 4424 ', () {
    CalTime cal = new CalTime();
    double hr = 0;
    var salary = 158.0;

    var StartTime = DateTime.parse("2020-06-20 17:00:00");
    var EndTime = DateTime.parse("2020-06-20 20:45:00");
    hr += cal.calHr(StartTime,EndTime); //3.75

    StartTime = DateTime.parse("2020-06-21 09:00:00");
    EndTime = DateTime.parse("2020-06-21 17:45:00");
    hr += cal.calHr(StartTime,EndTime); //8.75

    StartTime = DateTime.parse("2020-06-22 09:00:00");
    EndTime = DateTime.parse("2020-06-22 18:30:00");
    hr += cal.calHr(StartTime,EndTime); //9.5

    StartTime = DateTime.parse("2020-06-23 09:00:00");
    EndTime = DateTime.parse("2020-06-23 15:00:00");
    hr += cal.calHr(StartTime,EndTime); //6

    expect(cal.calPTSalary(hr,salary),4424);
  });

  test('Cal salary', () {
    CalTime cal = new CalTime();
    double hr = 0;
    double salary = 180.0;

    cal.setSalary(salary);

    var StartTime = DateTime.parse("2020-01-26 09:00:00");
    var EndTime = DateTime.parse("2020-01-26 17:45:00");
    hr += cal.calHr(StartTime,EndTime); //8.75

    // 時間錯誤
    StartTime = DateTime.parse("2020-01-26 09:00:00");
    EndTime = DateTime.parse("2020-01-26 07:15:00");
    hr += cal.calHr(StartTime,EndTime); //0

    StartTime = DateTime.parse("2020-01-27 09:00:00");
    EndTime = DateTime.parse("2020-01-27 17:00:00");
    hr += cal.calHr(StartTime,EndTime); //8

    StartTime = DateTime.parse("2020-01-28 09:20:00");
    EndTime = DateTime.parse("2020-01-28 18:00:00");
    hr += cal.calHr(StartTime,EndTime); //8.67

    StartTime = DateTime.parse("2020-01-29 10:00:00");
    EndTime = DateTime.parse("2020-01-29 15:30:00");
    hr += cal.calHr(StartTime,EndTime); //5.5

    expect(cal.calPTSalary(hr,salary),5580);
  });

  group('OT test', () {
    CalTime cal;
    MockCalTime server;

    setUp(() {
      server = new MockCalTime();
      cal = new CalTime();
      cal.setServer(server);
    });

    test('Is Full Time', () {
      var StartTime = DateTime.parse("2020-02-01 21:00:00");
      when(server.setFTSalary()).thenReturn(25000);
      expect(cal.calFTSalary(StartTime),0);

      StartTime = DateTime.parse("2020-02-14 21:00:00");
      when(server.setFTSalary()).thenReturn(28000);
      expect(cal.calFTSalary(StartTime),0);

      StartTime = DateTime.parse("2020-01-15 10:00:00");
      when(server.setFTSalary()).thenReturn(30000);
      expect(cal.calFTSalary(StartTime),30000);

      StartTime = DateTime.parse("2020-03-30 21:00:00");
      when(server.setFTSalary()).thenReturn(35000);
      expect(cal.calFTSalary(StartTime),35000);

      StartTime = DateTime.parse("2020-05-31 21:00:00");
      when(server.setFTSalary()).thenReturn(63000);
      expect(cal.calFTSalary(StartTime),63000);

      verify(server.setFTSalary()).called(5);
    });
  });

}