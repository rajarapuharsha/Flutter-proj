enum BiologicalSex { male, female }

enum ActivityLevel {
  sedentary('Sedentary', 'Little or no planned exercise', 1.2),
  light('Lightly active', 'Light exercise 1–3 days per week', 1.375),
  moderate('Moderately active', 'Moderate exercise 3–5 days per week', 1.55),
  very('Very active', 'Hard exercise 6–7 days per week', 1.725),
  extra('Extra active', 'Very intense exercise or demanding work', 1.9);

  const ActivityLevel(this.label, this.description, this.multiplier);
  final String label;
  final String description;
  final double multiplier;
}

enum CalorieGoal { maintain, gradualLoss, gradualGain }

class CalculatorResult {
  const CalculatorResult({
    required this.bmi,
    required this.category,
    required this.advice,
    required this.bmr,
    required this.maintenanceCalories,
    required this.goalCalories,
    required this.goal,
    required this.adultEstimate,
    required this.goalEligible,
    required this.goalNote,
  });

  final double bmi;
  final String category;
  final String advice;
  final double? bmr;
  final double? maintenanceCalories;
  final double? goalCalories;
  final CalorieGoal goal;
  final bool adultEstimate;
  final bool goalEligible;
  final String goalNote;
}
