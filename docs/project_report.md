# BMI & Daily Calorie Calculator — Healthy Living and SDG 3

## Title page

**Project:** BMI & Daily Calorie Calculator — Healthy Living and SDG 3  
**Technology:** Flutter and Dart  
**Student:** [Enter student name]  
**Institution / course:** [Enter institution and course]  
**Academic year:** [Enter academic year]  
**Guide:** [Enter guide name, if required]

## Abstract

This project is a responsive Flutter application that demonstrates calculation of Body Mass Index (BMI) and adult daily calorie estimates. It accepts age, height, weight, the sex selection used by the BMR equation, activity level, and a calorie goal. It presents an estimated BMI and adult category, basal metabolic rate (BMR), activity-adjusted maintenance calories, and a selected goal estimate. The app runs calculations locally and is intended for health education. It does not diagnose health conditions or replace qualified medical care.

## 1. Introduction

People encounter BMI and calorie figures in health education, but these measures can be misunderstood as diagnoses or precise individual prescriptions. This project presents common formula-based estimates with plain-language explanations and limits. It also demonstrates modular Flutter UI development, validation, conditional logic, and unit/widget testing.

## 2. Problem statement

Learners need a simple way to see how height, weight, age, equation selection, and activity level affect common health estimates while understanding that estimates are limited and are not a clinical assessment.

## 3. Objectives

- Calculate BMI from metric height and weight.
- Classify BMI into adult screening ranges.
- Estimate BMR using the Mifflin-St Jeor equations.
- Estimate maintenance and selected goal calories using activity multipliers.
- Validate inputs and provide a safe under-18 experience.
- Demonstrate responsive Flutter design and SDG 3 educational relevance.

## 4. Scope

The application calculates BMI for entered measurements and displays adult BMI categories only from age 18 onward. Adult BMR and calorie estimates are shown only for adults. It is not a medical record, diagnosis, dietary plan, or substitute for age-specific pediatric growth-chart evaluation.

## 5. SDG 3 relevance

The project relates to UN Sustainable Development Goal 3, Good Health and Well-Being, through educational awareness of body measurements, estimated energy needs, balanced nutrition, and physical activity. Target users are students and adults using the app for learning. Expected benefit is improved awareness; no measured health or social impact is claimed.

## 6. System requirements

- Flutter stable SDK and Dart 3.8 or later.
- Android Studio/Android SDK, Xcode on macOS, desktop toolchain, or web browser depending on target.
- Internet is required to obtain initial Flutter packages, but not for app calculations after setup.
- Keyboard and pointer or touch input.

## 7. Technology stack

Flutter, Dart with null safety, Material 3, built-in Flutter state handling, and Flutter test. The app has no runtime network dependency or third-party calculation package.

## 8. System architecture

The entry point (`main.dart`) starts `BmiCalorieApp` configured in `app.dart`. Screens own presentation state. Reusable form and result widgets are separated under `widgets/`. `CalculatorService` contains pure calculation functions; `InputValidator` contains field validation; `CalculatorResult` carries computed values. Documentation and automated checks are maintained separately.

## 9. Module descriptions

- `main.dart`, `app.dart`: application entry point and configuration.
- `models/calculator_result.dart`: sex, activity, goal, and result types.
- `services/calculator_service.dart`: BMI, category, advice, BMR, maintenance, and goal calculations.
- `services/input_validator.dart`: age, height, and weight limits.
- `screens/home_screen.dart`: dashboard and navigation.
- `screens/calculator_screen.dart`: form state, validation, calculation, and reset.
- `screens/about_screen.dart`: SDG 3, privacy, limitations, and disclaimer.
- `widgets/`: shared form fields, category indicator, and results card.
- `theme/app_theme.dart`: light and dark Material 3 themes.

## 10. BMI formula

BMI = weight in kilograms ÷ (height in metres × height in metres). The implementation converts centimetres to metres and displays one decimal place. Classification uses the unrounded value:

| Adult category | BMI range |
|---|---:|
| Underweight | below 18.5 |
| Normal weight | 18.5 to below 25 |
| Overweight | 25 to below 30 |
| Obesity | 30 or above |

These are adult screening categories; the app does not apply them to minors.

## 11. BMR formula

The app uses the Mifflin-St Jeor equation (units: kilograms, centimetres, years):

- Male equation: BMR = 10 × weight + 6.25 × height − 5 × age + 5.
- Female equation: BMR = 10 × weight + 6.25 × height − 5 × age − 161.

The sex control explicitly refers to the equation selection. These equations provide estimates and do not represent every person's physiology.

## 12. Activity multipliers

| Level | Description | Multiplier |
|---|---|---:|
| Sedentary | Little or no planned exercise | 1.2 |
| Lightly active | Light exercise 1–3 days per week | 1.375 |
| Moderately active | Moderate exercise 3–5 days per week | 1.55 |
| Very active | Hard exercise 6–7 days per week | 1.725 |
| Extra active | Very intense exercise or demanding work | 1.9 |

Maintenance estimate = BMR × selected activity multiplier.

## 13. Calorie goal estimate

The goal estimate is maintenance for weight maintenance, maintenance minus 300 kcal/day for gradual loss, or maintenance plus 300 kcal/day for gradual gain. The displayed result applies a 1,200 kcal/day floor to the resulting estimate. This floor is a software guardrail, not a safe intake recommendation. An underweight BMI result suppresses the gradual-loss target and directs users to professional advice. Non-positive BMR results are not used. Individual energy needs vary; users should seek professional advice before making dietary changes. No calorie estimates are provided below age 18.

## 14. Conditional logic

BMI values below 18.5, 25, and 30 determine adult categories. Age determines whether adult categories and calorie estimates are shown. The selected sex adjusts the BMR constant; activity selects the multiplier; goal selects the calorie adjustment. Invalid or non-finite numbers are rejected.

## 15. Input validation

Age must be a whole number from 5 through 120. Height must be from 50 through 280 cm. Weight must be from 10 through 500 kg. Form errors appear next to the corresponding fields, and calculation is blocked until the fields pass validation.

## 16. UI design

The app uses Material 3, teal/blue health accents, rounded cards, a responsive centered content width, a dashboard, and a form/results view that shifts from stacked to two-column at wider sizes. The BMI indicator uses segment labels in addition to color. System light and dark appearance are supported.

**Screenshots:** Add screenshots captured from an actual running build in `docs/screenshots/`; none are included yet.

## 17. Testing methodology and actual results

Unit tests cover known BMI values, adult boundaries, invalid inputs, both BMR equations, activity multipliers, calorie adjustments, input validation, under-18 behavior, and underweight-goal safety. Widget tests cover dashboard navigation, required-field validation, calculation results, and reset. On Flutter 3.41.4 / Dart 3.11.1, `dart format .`, `flutter analyze`, and `flutter test` completed successfully; see `testing_report.md` for platform build outcomes.

## 18. Platform compatibility

The code uses Flutter widgets and no mobile-only APIs. Flutter-generated platform runner folders are included for Android, iOS, web, Windows, macOS, and Linux. Android requires Android SDK/build tools; iOS/macOS require macOS and Xcode; Windows requires Windows desktop tooling; Linux requires Linux development packages; web requires Flutter web support. This Windows environment built web; Android and Windows build blockers are recorded in `testing_report.md`.

## 19. Privacy and safety

Measurements are kept in screen state and are neither transmitted nor persisted. The app gives general educational information only. BMI has important limitations, and calories are estimates. Under-18 users are directed toward age-specific professional assessment. Users should consult a qualified professional for personal guidance.

## 20. Limitations

BMI does not distinguish lean mass from fat mass and does not account for all body composition, age, or clinical factors. BMR and activity estimates can differ from actual energy needs. The goal adjustment is a simple educational example, not individualized nutrition advice. The app does not connect to a clinical data source.

## 21. Future enhancements

Possible extensions include localization, user-selected units, accessible chart narration, optional local history with explicit consent, and more detailed educational references. Any health feature should be reviewed for safety and accessibility.

## 22. Conclusion

The project demonstrates a modular Flutter health-education app with BMI and calorie calculation logic, input checks, responsive screens, under-18 safeguards, and SDG 3 context. The web release build and automated checks passed. Android and Windows builds need local toolchain repairs; iOS, macOS, and Linux builds require their respective host environments. Capture screenshots from the running app before final academic submission.

## References

- World Health Organization, *Obesity: Preventing and Managing the Global Epidemic*, WHO Technical Report Series 894, 2000. [WHO report](https://iris.who.int/bitstream/handle/10665/42330/WHO_TRS_894.pdf)
- Mifflin MD et al., “A new predictive equation for resting energy expenditure in healthy individuals,” *The American Journal of Clinical Nutrition*, 1990; 51(2):241–247. [PubMed record](https://pubmed.ncbi.nlm.nih.gov/2305711/)
- United Nations, Sustainable Development Goal 3: Good Health and Well-Being. [UN Goal 3](https://sdgs.un.org/goals/goal3)
- Flutter documentation. [Flutter docs](https://docs.flutter.dev/)
