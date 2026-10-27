import 'package:flutter/material.dart';

import '../models/calculator_result.dart';
import '../services/calculator_service.dart';
import '../services/input_validator.dart';
import '../widgets/input_form.dart';
import '../widgets/result_card.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _age = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  BiologicalSex _sex = BiologicalSex.female;
  ActivityLevel _activity = ActivityLevel.sedentary;
  CalorieGoal _goal = CalorieGoal.maintain;
  CalculatorResult? _result;

  @override
  void dispose() {
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  void _calculate({bool showErrors = true}) {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) {
      if (showErrors) setState(() => _result = null);
      return;
    }
    final result = CalculatorService.calculate(
      age: int.parse(_age.text.trim()),
      heightCm: double.parse(_height.text.trim()),
      weightKg: double.parse(_weight.text.trim()),
      sex: _sex,
      activity: _activity,
      goal: _goal,
    );
    setState(() => _result = result);
  }

  void _reset() {
    _formKey.currentState?.reset();
    _age.clear();
    _height.clear();
    _weight.clear();
    setState(() {
      _sex = BiologicalSex.female;
      _activity = ActivityLevel.sedentary;
      _goal = CalorieGoal.maintain;
      _result = null;
    });
  }

  void _changeSex(BiologicalSex value) {
    setState(() => _sex = value);
    if (_result != null) _calculate(showErrors: false);
  }

  void _changeActivity(ActivityLevel value) {
    setState(() => _activity = value);
    if (_result != null) _calculate(showErrors: false);
  }

  void _changeGoal(CalorieGoal value) {
    setState(() => _goal = value);
    if (_result != null) _calculate(showErrors: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('BMI & calorie calculator')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 820;
            final form = _buildForm(context);
            final result = _result == null
                ? _EmptyResult(onTap: () => _calculate())
                : ResultCard(result: _result!);
            if (wide) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: form),
                    const SizedBox(width: 24),
                    Expanded(child: result),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [form, const SizedBox(height: 20), result],
              ),
            );
          },
        ),
      ),
    ),
  );

  Widget _buildForm(BuildContext context) => Form(
    key: _formKey,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your details',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            const SectionTitle('Personal details'),
            const SizedBox(height: 12),
            NumberInput(
              controller: _age,
              label: 'Age',
              suffix: 'years',
              wholeNumber: true,
              validator: InputValidator.age,
            ),
            const SizedBox(height: 10),
            Text(
              'Sex used for BMR equation',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            RadioGroup<BiologicalSex>(
              groupValue: _sex,
              onChanged: (value) {
                if (value != null) {
                  _changeSex(value);
                }
              },
              child: const Column(
                children: [
                  ChoiceTile<BiologicalSex>(
                    title: 'Female',
                    value: BiologicalSex.female,
                  ),
                  ChoiceTile<BiologicalSex>(
                    title: 'Male',
                    value: BiologicalSex.male,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const SectionTitle(
              'Body measurements',
              subtitle: 'Use your current height and weight.',
            ),
            const SizedBox(height: 12),
            NumberInput(
              controller: _height,
              label: 'Height',
              suffix: 'cm',
              validator: InputValidator.height,
            ),
            const SizedBox(height: 12),
            NumberInput(
              controller: _weight,
              label: 'Weight',
              suffix: 'kg',
              validator: InputValidator.weight,
            ),
            const SizedBox(height: 20),
            const SectionTitle('Activity'),
            const SizedBox(height: 12),
            ActivityDropdown(value: _activity, onChanged: _changeActivity),
            const SizedBox(height: 20),
            const SectionTitle('Calorie goal'),
            const SizedBox(height: 12),
            DropdownButtonFormField<CalorieGoal>(
              initialValue: _goal,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Choose a goal'),
              items: const [
                DropdownMenuItem(
                  value: CalorieGoal.maintain,
                  child: Text('Maintain weight'),
                ),
                DropdownMenuItem(
                  value: CalorieGoal.gradualLoss,
                  child: Text('Gradual weight loss'),
                ),
                DropdownMenuItem(
                  value: CalorieGoal.gradualGain,
                  child: Text('Gradual weight gain'),
                ),
              ],
              onChanged: (v) {
                if (v != null) _changeGoal(v);
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text('Calculate'),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Adult calorie formulas are intended for ages 18+. Under 18, the app shows BMI only and directs users to age-specific professional assessment.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}

class _EmptyResult extends StatelessWidget {
  const _EmptyResult({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Icon(
            Icons.insights_outlined,
            size: 52,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Your results will appear here',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your details and calculate to see your BMI and estimated daily calories.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_upward),
            label: const Text('Check required fields'),
          ),
        ],
      ),
    ),
  );
}
