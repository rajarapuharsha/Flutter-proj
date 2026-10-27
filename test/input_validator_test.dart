import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/services/input_validator.dart';

void main() {
  group('Input validation', () {
    test('accepts valid age, height, and weight', () {
      expect(InputValidator.age('18'), isNull);
      expect(InputValidator.height('172.5'), isNull);
      expect(InputValidator.weight('68.2'), isNull);
    });

    test('rejects missing and out-of-range age', () {
      expect(InputValidator.age(''), isNotNull);
      expect(InputValidator.age('17.5'), isNotNull);
      expect(InputValidator.age('121'), isNotNull);
    });

    test('rejects malformed, non-finite, and out-of-range measurements', () {
      expect(InputValidator.height('abc'), isNotNull);
      expect(InputValidator.height('NaN'), isNotNull);
      expect(InputValidator.height('281'), isNotNull);
      expect(InputValidator.weight('Infinity'), isNotNull);
      expect(InputValidator.weight('9'), isNotNull);
      expect(InputValidator.weight('501'), isNotNull);
    });
  });
}
