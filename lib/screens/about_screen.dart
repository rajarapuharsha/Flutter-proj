import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('About this project')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            _AboutBlock(
              icon: Icons.flag_outlined,
              title: 'Purpose',
              text:
                  'A student-built health education tool that demonstrates BMI and calorie estimate calculations using Flutter and Dart.',
            ),
            SizedBox(height: 14),
            _AboutBlock(
              icon: Icons.public_outlined,
              title: 'SDG 3: Good Health and Well-Being',
              text:
                  'The project promotes awareness of body measurements, energy needs, balanced nutrition, and regular physical activity. Expected benefit is educational; no measured social impact is claimed.',
            ),
            SizedBox(height: 14),
            _AboutBlock(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy and limitations',
              text:
                  'All calculations run locally. The app does not send or save entered measurements. BMI is a screening measure and calorie estimates are approximate. Adult BMI categories do not apply to children and teenagers.',
            ),
            SizedBox(height: 14),
            _AboutBlock(
              icon: Icons.medical_information_outlined,
              title: 'Health disclaimer',
              text:
                  'This app is for general education and is not medical advice. Talk to a qualified health professional before making decisions about nutrition, weight, or health.',
            ),
          ],
        ),
      ),
    ),
  );
}

class _AboutBlock extends StatelessWidget {
  const _AboutBlock({
    required this.icon,
    required this.title,
    required this.text,
  });
  final IconData icon;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(text),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
