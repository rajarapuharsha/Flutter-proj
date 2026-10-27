import 'package:flutter/material.dart';
import '../models/calculator_result.dart';
import 'bmi_indicator.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.result});
  final CalculatorResult result;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your estimate',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                result.bmi.toStringAsFixed(1),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'BMI\n${result.category}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (result.adultEstimate && result.bmr != null) ...[
            const SizedBox(height: 16),
            BmiIndicator(bmi: result.bmi),
          ],
          const SizedBox(height: 20),
          _AdviceBox(result.advice),
          if (result.adultEstimate) ...[
            const Divider(height: 32),
            _MetricRow(
              label: 'Estimated BMR',
              value: '${result.bmr!.round()} kcal/day',
              icon: Icons.bedtime_outlined,
            ),
            const SizedBox(height: 12),
            _MetricRow(
              label: 'Maintenance estimate',
              value: '${result.maintenanceCalories!.round()} kcal/day',
              icon: Icons.balance_outlined,
            ),
            const SizedBox(height: 12),
            if (result.goalEligible && result.goalCalories != null)
              _MetricRow(
                label: _goalLabel(result.goal),
                value: '${result.goalCalories!.round()} kcal/day',
                icon: Icons.flag_outlined,
                emphasize: true,
              )
            else
              Text(result.goalNote),
            const SizedBox(height: 10),
            Text(
              'Calorie values are rough educational estimates. Individual needs vary.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ] else if (result.adultEstimate) ...[
            const Divider(height: 32),
            Text(result.goalNote),
          ],
        ],
      ),
    ),
  );

  static String _goalLabel(CalorieGoal goal) => switch (goal) {
    CalorieGoal.maintain => 'Maintain weight estimate',
    CalorieGoal.gradualLoss => 'Gradual loss estimate',
    CalorieGoal.gradualGain => 'Gradual gain estimate',
  };
}

class _AdviceBox extends StatelessWidget {
  const _AdviceBox(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: .55),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Text(text),
  );
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    required this.icon,
    this.emphasize = false,
  });
  final String label;
  final String value;
  final IconData icon;
  final bool emphasize;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: Theme.of(context).colorScheme.primary),
      const SizedBox(width: 10),
      Expanded(
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
      Text(
        value,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: emphasize ? FontWeight.bold : FontWeight.w600,
        ),
      ),
    ],
  );
}
