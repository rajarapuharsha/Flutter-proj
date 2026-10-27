# User Manual

## Start the application

Install Flutter stable and a target platform toolchain. In the project folder run:

```sh
flutter pub get
flutter run
```

## Use the calculator

1. Open **Open calculator** from the dashboard.
2. Enter age in years, height in centimetres, and weight in kilograms.
3. Choose the equation sex used for the BMR formula.
4. Choose an activity level and calorie goal.
5. Select **Calculate**. Invalid entries show a message beneath the field.
6. Read the BMI, adult screening category, advice, BMR, maintenance estimate, and goal estimate.
7. Changing sex, activity, or goal recalculates an already displayed result. Change measurements and press **Calculate** again.
8. Select **Reset** to clear all fields, validation, and results.

For users under 18, the app provides an informational BMI display but does not assign adult categories or calculate calories. A qualified professional should use age-specific growth charts.

## Understand the numbers

BMI is a screening measure based on weight and height. Calorie estimates use a predictive BMR equation and activity multiplier. Neither result is a diagnosis or individualized care plan. Consult a qualified health professional for personal decisions.

## Navigation and accessibility

Use the About button for the project purpose, SDG 3 alignment, privacy note, and limitations. The layout adapts to narrow and wide displays. Form fields can be reached by keyboard and are labeled.
