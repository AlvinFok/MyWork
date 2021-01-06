import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_app/homepage.dart';

class MockServer extends Mock implements Server {}

void main() {
  group('MilliSeconds to time', () {
    final homepage = new HomePage();
    test('MilliSeconds to second', () {
      //1000 milli seconds equal 1 second
      expect(homepage.transformMilliSeconds(-1), '00:00:00'); //min- for second
      expect(homepage.transformMilliSeconds(0), '00:00:00'); //min for second
      expect(homepage.transformMilliSeconds(1), '00:00:00'); //min+ for second
      expect(
          homepage.transformMilliSeconds(1000), '00:00:01'); //normal for second
      expect(
          homepage.transformMilliSeconds(59999), '00:00:59'); //max- for second
      expect(
          homepage.transformMilliSeconds(60000), '00:01:00'); //max for second
      expect(
          homepage.transformMilliSeconds(61000), '00:01:01'); //max+ for second
    });

    test('MilliSeconds to minutes', () {
      //60000 milli seconds equal 1 minute
      // expect(
      //     homepage.transformMilliSeconds(59999), '00:00:59'); //min- for minute
      // expect(
      //     homepage.transformMilliSeconds(60000), '00:01:00'); //min for minute
      // expect(
      //     homepage.transformMilliSeconds(61000), '00:01:01'); //min+ for minute
      expect(homepage.transformMilliSeconds(120000),
          '00:02:00'); //normal for minute
      expect(homepage.transformMilliSeconds(3599999),
          '00:59:59'); //max- for minute
      expect(
          homepage.transformMilliSeconds(3600000), '01:00:00'); //max for minute
      expect(homepage.transformMilliSeconds(3601000),
          '01:00:01'); //max+ for minute
    });

    test('MilliSeconds to hours', () {
      //60000 milli seconds equal 1 hour
      // expect(
      //     homepage.transformMilliSeconds(3599999), '00:59:59'); //min- for hour
      // expect(
      //     homepage.transformMilliSeconds(3600000), '01:00:00'); //min for hour
      // expect(
      //     homepage.transformMilliSeconds(3601000), '01:00:01'); //min+ for hour
      expect(homepage.transformMilliSeconds(7200000),
          '02:00:00'); //normal for hour
      expect(
          homepage.transformMilliSeconds(86399999), '23:59:59'); //max- for hour
      expect(
          homepage.transformMilliSeconds(86400000), '24:00:00'); //max for hour
      expect(
          homepage.transformMilliSeconds(86401000), '24:00:01'); //max+ for hour
    });
  });

  group('OT test', () {
    HomePage homepage;
    MockServer server;
    setUp(() {
      server = new MockServer();
      homepage = new HomePage();
      homepage.setServer(server);
      
    });

    test('OT function test', () {
      when(server.getTotalHoursOfThisMonth()).thenReturn(300);
      expect(homepage.isOT(), true);
      when(server.getTotalHoursOfThisMonth()).thenReturn(200);
      expect(homepage.isOT(), false);
      verify(server.getTotalHoursOfThisMonth()).called(2);
    });
  });
}
