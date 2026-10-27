import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/app.dart';

void main() {
  testWidgets('shows the dashboard and opens calculator', (tester) async {
    await tester.pumpWidget(const BmiCalorieApp());
    expect(find.text('Understand your health numbers'), findsOneWidget);
    await tester.tap(find.text('Open calculator'));
    await tester.pumpAndSettle();
    expect(find.text('Your details'), findsOneWidget);
    expect(find.text('Your results will appear here'), findsOneWidget);
  });

  testWidgets('validates required inputs and calculates results', (
    tester,
  ) async {
    await tester.pumpWidget(const BmiCalorieApp());
    await tester.tap(find.text('Open calculator'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Calculate'));
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your age in whole years.'), findsOneWidget);
    final fields = find.byType(TextFormField);
    await tester.ensureVisible(fields.at(0));
    await tester.enterText(fields.at(0), '30');
    await tester.ensureVisible(fields.at(1));
    await tester.enterText(fields.at(1), '170');
    await tester.ensureVisible(fields.at(2));
    await tester.enterText(fields.at(2), '70');
    await tester.ensureVisible(find.text('Calculate'));
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();
    expect(find.text('Your estimate'), findsOneWidget);
    expect(find.text('24.2'), findsOneWidget);
    await tester.ensureVisible(find.text('Reset'));
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    expect(find.text('Your results will appear here'), findsOneWidget);
    expect(
      tester.widget<TextFormField>(fields.at(0)).controller!.text,
      isEmpty,
    );
  });
}
