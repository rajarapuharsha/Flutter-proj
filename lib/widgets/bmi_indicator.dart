import 'package:flutter/material.dart';

class BmiIndicator extends StatelessWidget {
  const BmiIndicator({super.key, required this.bmi});
  final double bmi;
  @override
  Widget build(BuildContext context) {
    final colors = [Colors.blue, Colors.teal, Colors.orange, Colors.red];
    final labels = ['Under 18.5', '18.5–24.9', '25–29.9', '30+'];
    final position = (bmi.clamp(10, 40) - 10) / 30;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: List.generate(
                    4,
                    (i) => Expanded(
                      child: Container(
                        height: 14,
                        margin: EdgeInsets.only(right: i == 3 ? 0 : 3),
                        decoration: BoxDecoration(
                          color: colors[i],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth * position)
                      .clamp(0, constraints.maxWidth - 2)
                      .toDouble(),
                  top: -6,
                  child: Container(
                    width: 4,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            4,
            (i) => Expanded(
              child: Text(
                labels[i],
                textAlign: i == 0 ? TextAlign.left : TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Adult screening ranges. BMI is a general screening measure, not a diagnosis.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
