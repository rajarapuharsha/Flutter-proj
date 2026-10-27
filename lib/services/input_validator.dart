class InputValidator {
  static String? age(String? value) {
    final parsed = int.tryParse(value?.trim() ?? '');
    if (parsed == null) {
      return 'Enter your age in whole years.';
    }
    if (parsed < 5 || parsed > 120) {
      return 'Age must be between 5 and 120 years.';
    }
    return null;
  }

  static String? height(String? value) {
    final parsed = double.tryParse(value?.trim() ?? '');
    if (parsed == null || !parsed.isFinite) {
      return 'Enter a valid height in centimeters.';
    }
    if (parsed < 50 || parsed > 280) {
      return 'Height must be between 50 and 280 cm.';
    }
    return null;
  }

  static String? weight(String? value) {
    final parsed = double.tryParse(value?.trim() ?? '');
    if (parsed == null || !parsed.isFinite) {
      return 'Enter a valid weight in kilograms.';
    }
    if (parsed < 10 || parsed > 500) {
      return 'Weight must be between 10 and 500 kg.';
    }
    return null;
  }
}
