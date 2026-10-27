import 'package:flutter/material.dart';
import '../models/calculator_result.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.suffix,
    this.wholeNumber = false,
  });
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final String? suffix;
  final bool wholeNumber;
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: TextInputType.numberWithOptions(decimal: !wholeNumber),
    textInputAction: TextInputAction.next,
    validator: validator,
    decoration: InputDecoration(labelText: label, suffixText: suffix),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.subtitle});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      if (subtitle != null) ...[
        const SizedBox(height: 4),
        Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
      ],
    ],
  );
}

class ChoiceTile<T> extends StatelessWidget {
  const ChoiceTile({super.key, required this.title, required this.value});
  final String title;
  final T value;
  @override
  Widget build(BuildContext context) => RadioListTile<T>(
    value: value,
    title: Text(title),
    contentPadding: EdgeInsets.zero,
    dense: true,
  );
}

class ActivityDropdown extends StatelessWidget {
  const ActivityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final ActivityLevel value;
  final ValueChanged<ActivityLevel> onChanged;
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<ActivityLevel>(
    initialValue: value,
    isExpanded: true,
    decoration: const InputDecoration(labelText: 'Activity level'),
    items: ActivityLevel.values
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(
              '${item.label} — ${item.description}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList(),
    onChanged: (v) {
      if (v != null) onChanged(v);
    },
  );
}
