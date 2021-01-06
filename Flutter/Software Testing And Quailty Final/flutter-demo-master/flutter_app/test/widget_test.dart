// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

void main() {
  group('Home page widget test', () {
    // testWidgets('Stopwacth test', (WidgetTester tester) async {
    //   // Build our app and trigger a frame.
    //   await tester.pumpWidget(MyApp());
    //   //find clcok button and tap it
    //   var clockInButton = find.text('Clock In');
    //   expect(clockInButton, findsOneWidget);
    //   await tester.tap(clockInButton);
    //   await tester.pump(Duration(seconds: 2));
    //   //find pause button and tap it
    //   var pauseButton = find.text('Pause');
    //   expect(pauseButton, findsOneWidget);
    //   await tester.tap(pauseButton);
    //   await tester.pump();
    //   // //find clock out button and tap it
    //   // var clockOutButton = find.text('Clock Out');
    //   // clockInButton = find.text('Clock In');//after tap pause it will show clock in button again
    //   // await tester.tap(clockOutButton);
    //   // await tester.pump();
    //   //expect(find.text('00HR:00MIN:01SEC'), findsOneWidget);

    //   // Verify that our counter starts at 0.
    // });

    testWidgets('Setting button test', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      //find setting button and tap it
      var settingButton = find.byIcon(Icons.settings);
      expect(settingButton, findsOneWidget);
      await tester.tap(settingButton);
      await tester.pump();

      //find logout button and tap it
      var logoutButton = find.byIcon(Icons.power_settings_new);
      expect(logoutButton, findsOneWidget);
      await tester.tap(logoutButton);
      await tester.pump();

      //tap setting button again and go back to home oage
      await tester.tap(settingButton);
      await tester.pump();
    });
  });

  group('leave page test', () {
    testWidgets('Enter page test', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      var leaveButton = find.byIcon(Icons.airline_seat_individual_suite);
      expect(leaveButton, findsOneWidget);
      await tester.tap(leaveButton);
      await tester.pump();
    });
  });
  group('salary page test', () {
    testWidgets('Enter salary page test', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      var salaryButton = find.byIcon(Icons.attach_money);
      expect(salaryButton, findsOneWidget);
      await tester.tap(salaryButton);
      await tester.pump();
    });

    testWidgets('Salary table change test', (WidgetTester tester) async {
      //enter salary test first
      await tester.pumpWidget(MyApp());
      var salaryButton = find.byIcon(Icons.attach_money);
      expect(salaryButton, findsOneWidget);
      await tester.tap(salaryButton);
      await tester.pumpAndSettle();

      //find before button and tap it
      var beforeButton = find.byIcon(Icons.navigate_before);
      expect(beforeButton, findsOneWidget);
      await tester.tap(beforeButton);
      await tester.pump();

      //find after button and tap it
      var afterButton = find.byIcon(Icons.navigate_next);
      expect(afterButton, findsOneWidget);
      await tester.tap(afterButton);
      await tester.pump();
    });
  });

  group('Calendar page test', () {
    testWidgets('Enter calaender page test', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      var calaenderButton = find.byIcon(Icons.calendar_today);
      expect(calaenderButton, findsOneWidget);
      await tester.tap(calaenderButton);
      await tester.pumpAndSettle();
    });

    testWidgets('Calaender month change test', (WidgetTester tester) async {
      //enter calaender page first
      await tester.pumpWidget(MyApp());
      var calaenderButton = find.byIcon(Icons.calendar_today);
      expect(calaenderButton, findsOneWidget);
      await tester.tap(calaenderButton);
      await tester.pumpAndSettle();

      //find before button and tap it
      var beforeButton = find.byIcon(Icons.navigate_before);
      expect(beforeButton, findsOneWidget);
      await tester.tap(beforeButton);
      await tester.pump();

      //find after button and tap it
      var afterButton = find.byIcon(Icons.navigate_next);
      expect(afterButton, findsOneWidget);
      await tester.tap(afterButton);
      await tester.pump();
    });

    // testWidgets('Calaender day select test', (WidgetTester tester) async {
    //   //enter calaender page first
    //   await tester.pumpWidget(MyApp());
    //   var calaenderButton = find.byIcon(Icons.calendar_today);
    //   expect(calaenderButton, findsOneWidget);
    //   await tester.tap(calaenderButton);
    //   await tester.pumpAndSettle();

    //   //find day 17 and tap it
    //   var day = find.descendant(
    //       of: find.byWidget(CalendarViewWidget), matching: find.text('17假'));
    //   //var day = find.byType(CalendarController);
    //   expect(day, findsOneWidget);
    //   await tester.tap(day);
    //   await tester.pump();
    // });

    testWidgets('Enter arrangment page from calendar page test',
        (WidgetTester tester) async {
      //enter calaender page first
      await tester.pumpWidget(MyApp());
      var calaenderButton = find.byIcon(Icons.calendar_today);
      expect(calaenderButton, findsOneWidget);
      await tester.tap(calaenderButton);
      await tester.pumpAndSettle();

      //find + button and tap it go to arrangment page
      var arrangmentButton = find.byIcon(Icons.add);
      expect(arrangmentButton, findsOneWidget);
      await tester.tap(arrangmentButton);
      await tester.pumpAndSettle();

      //find date selecter
      var dateSelecter = find.byKey(Key('date input'));
      expect(dateSelecter, findsOneWidget);

      //find title text field
      var titleTextField = find.byKey(Key('title'));
      expect(titleTextField, findsOneWidget);
      //enter tilt
      await tester.enterText(titleTextField, 'test');
      //tap date selecter
      await tester.tap(dateSelecter);
      await tester.pumpAndSettle();

      //find add icon and tap import
      var addButton = find.byIcon(Icons.add);
      expect(addButton, findsOneWidget);
      await tester.tap(addButton);
      await tester.pump();
    });
  });
}
