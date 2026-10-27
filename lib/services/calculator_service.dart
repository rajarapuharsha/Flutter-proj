import 'dart:math' as math;

import '../models/calculator_result.dart';

class CalculatorService {
  static double calculateBMI(double weightKg, double heightCm) {
    if (!weightKg.isFinite ||
        !heightCm.isFinite ||
        weightKg <= 0 ||
        heightCm <= 0) {
      throw ArgumentError('Weight and height must be positive finite numbers.');
    }
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  static String getBMICategory(double bmi) {
    if (!bmi.isFinite || bmi <= 0) {
      throw ArgumentError.value(bmi, 'bmi');
    }
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obesity';
  }

  static String getBMIAdvice(String category) => switch (category) {
    'Underweight' =>
      'Consider balanced, nourishing meals and ask a qualified health professional about your individual needs.',
    'Normal weight' =>
      'Keep supporting your wellbeing with balanced nutrition, regular movement, and healthy routines.',
    'Overweight' =>
      'Small sustainable habits can support wellbeing. A health professional can offer advice tailored to you.',
    'Obesity' =>
      'A BMI result is only one screening measure. Consider discussing your overall health with a qualified professional.',
    _ =>
      'Use this estimate as general education and seek qualified advice for personal health decisions.',
  };

  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required BiologicalSex sex,
  }) {
    if (!weightKg.isFinite ||
        !heightCm.isFinite ||
        weightKg <= 0 ||
        heightCm <= 0 ||
        age <= 0) {
      throw ArgumentError('BMR inputs must be positive and finite.');
    }
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    return base + (sex == BiologicalSex.male ? 5 : -161);
  }

  static double getActivityMultiplier(ActivityLevel level) => level.multiplier;

  static double calculateMaintenanceCalories(
    double bmr,
    ActivityLevel activity,
  ) {
    if (!bmr.isFinite || bmr <= 0) {
      throw ArgumentError.value(bmr, 'bmr');
    }
    return bmr * getActivityMultiplier(activity);
  }

  static double calculateGoalCalories(double maintenance, CalorieGoal goal) {
    if (!maintenance.isFinite || maintenance <= 0) {
      throw ArgumentError.value(maintenance, 'maintenance');
    }
    final adjusted = switch (goal) {
      CalorieGoal.maintain => maintenance,
      CalorieGoal.gradualLoss => maintenance - 300,
      CalorieGoal.gradualGain => maintenance + 300,
    };
    return math.max(1200.0, adjusted);
  }

  static CalculatorResult calculate({
    required double weightKg,
    required double heightCm,
    required int age,
    required BiologicalSex sex,
    required ActivityLevel activity,
    required CalorieGoal goal,
  }) {
    final bmi = calculateBMI(weightKg, heightCm);
    final adultEstimate = age >= 18;
    final category = adultEstimate
        ? getBMICategory(bmi)
        : 'Adult BMI categories do not apply';
    if (!adultEstimate) {
      return CalculatorResult(
        bmi: bmi,
        category: category,
        advice:
            'For people under 18, BMI is interpreted using age- and sex-specific growth charts. Please ask a qualified health professional; calorie estimates are not provided.',
        bmr: null,
        maintenanceCalories: null,
        goalCalories: null,
        goal: goal,
        adultEstimate: false,
        goalEligible: false,
        goalNote:
            'Adult calorie estimates are not provided for people under 18.',
      );
    }
    final bmr = calculateBMR(
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
      sex: sex,
    );
    if (bmr <= 0) {
      return CalculatorResult(
        bmi: bmi,
        category: category,
        advice:
            'This combination of measurements does not produce a usable BMR estimate. Please check the entries and ask a qualified health professional for personal guidance.',
        bmr: null,
        maintenanceCalories: null,
        goalCalories: null,
        goal: goal,
        adultEstimate: true,
        goalEligible: false,
        goalNote: 'A calorie goal estimate is unavailable for these entries.',
      );
    }
    final maintenance = calculateMaintenanceCalories(bmr, activity);
    final goalEligible =
        !(category == 'Underweight' && goal == CalorieGoal.gradualLoss);
    return CalculatorResult(
      bmi: bmi,
      category: category,
      advice: getBMIAdvice(category),
      bmr: bmr,
      maintenanceCalories: maintenance,
      goalCalories: goalEligible
          ? calculateGoalCalories(maintenance, goal)
          : null,
      goal: goal,
      adultEstimate: true,
      goalEligible: goalEligible,
      goalNote: goalEligible
          ? ''
          : 'A weight-loss estimate is not shown for an underweight BMI result. Seek advice from a qualified health professional.',
    );
  }
}
