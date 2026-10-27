import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/models/calculator_result.dart';
import 'package:bmi_calorie_calculator/services/calculator_service.dart';

void main() {
  group('BMI calculations', () {
    test('calculates known BMI', () {
      expect(CalculatorService.calculateBMI(70, 175), closeTo(22.857, .001));
    });
    test('classifies adult BMI boundaries correctly', () {
      expect(CalculatorService.getBMICategory(18.49), 'Underweight');
      expect(CalculatorService.getBMICategory(18.5), 'Normal weight');
      expect(CalculatorService.getBMICategory(24.99), 'Normal weight');
      expect(CalculatorService.getBMICategory(25), 'Overweight');
      expect(CalculatorService.getBMICategory(29.99), 'Overweight');
      expect(CalculatorService.getBMICategory(30), 'Obesity');
    });
    test('rejects invalid measurements', () {
      expect(() => CalculatorService.calculateBMI(0, 175), throwsArgumentError);
      expect(() => CalculatorService.calculateBMI(70, 0), throwsArgumentError);
      expect(
        () => CalculatorService.calculateBMI(double.infinity, 175),
        throwsArgumentError,
      );
    });
  });

  group('Calorie estimates', () {
    test('uses Mifflin-St Jeor equations for male and female examples', () {
      expect(
        CalculatorService.calculateBMR(
          weightKg: 70,
          heightCm: 170,
          age: 30,
          sex: BiologicalSex.male,
        ),
        1617.5,
      );
      expect(
        CalculatorService.calculateBMR(
          weightKg: 70,
          heightCm: 170,
          age: 30,
          sex: BiologicalSex.female,
        ),
        1451.5,
      );
    });
    test('applies all activity multipliers', () {
      const expected = [1.2, 1.375, 1.55, 1.725, 1.9];
      for (var i = 0; i < ActivityLevel.values.length; i++) {
        expect(
          CalculatorService.getActivityMultiplier(ActivityLevel.values[i]),
          expected[i],
        );
      }
    });
    test('estimates maintenance and each goal adjustment', () {
      expect(
        CalculatorService.calculateMaintenanceCalories(
          2000,
          ActivityLevel.sedentary,
        ),
        2400,
      );
      expect(
        CalculatorService.calculateGoalCalories(2400, CalorieGoal.maintain),
        2400,
      );
      expect(
        CalculatorService.calculateGoalCalories(2400, CalorieGoal.gradualLoss),
        2100,
      );
      expect(
        CalculatorService.calculateGoalCalories(2400, CalorieGoal.gradualGain),
        2700,
      );
      expect(
        CalculatorService.calculateGoalCalories(1300, CalorieGoal.gradualLoss),
        1200,
      );
    });
    test('does not provide adult calorie values under 18', () {
      final result = CalculatorService.calculate(
        weightKg: 50,
        heightCm: 160,
        age: 16,
        sex: BiologicalSex.female,
        activity: ActivityLevel.moderate,
        goal: CalorieGoal.gradualLoss,
      );
      expect(result.adultEstimate, isFalse);
      expect(result.maintenanceCalories, isNull);
      expect(result.category, contains('do not apply'));
      expect(result.goalEligible, isFalse);
    });
    test('does not provide a weight-loss target for underweight BMI', () {
      final result = CalculatorService.calculate(
        weightKg: 40,
        heightCm: 170,
        age: 30,
        sex: BiologicalSex.female,
        activity: ActivityLevel.sedentary,
        goal: CalorieGoal.gradualLoss,
      );
      expect(result.category, 'Underweight');
      expect(result.goalEligible, isFalse);
      expect(result.goalCalories, isNull);
    });
    test('rejects invalid BMR inputs', () {
      expect(
        () => CalculatorService.calculateBMR(
          weightKg: 70,
          heightCm: 170,
          age: 0,
          sex: BiologicalSex.male,
        ),
        throwsArgumentError,
      );
      expect(
        () => CalculatorService.calculateMaintenanceCalories(
          double.nan,
          ActivityLevel.light,
        ),
        throwsArgumentError,
      );
    });
  });
}
