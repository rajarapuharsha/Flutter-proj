# BMI & Daily Calorie Calculator — Healthy Living and SDG 3

A responsive, offline-first Flutter learning app that calculates BMI and educational daily calorie estimates. It explains the limits of these estimates and aligns its educational purpose with UN Sustainable Development Goal 3: Good Health and Well-Being.

## Problem statement and objectives

Learners need a simple way to understand common BMI and energy estimates without treating them as a diagnosis or precise prescription. This project demonstrates BMI calculation, adult category boundaries, BMR and activity-based calorie estimates, input validation, responsive Flutter UI, and responsible health messaging.

## Features

- BMI calculation and adult category classification with an indicator.
- Mifflin-St Jeor BMR equations, five activity multipliers, maintenance estimate, and selectable goal estimate.
- Input validation, recalculation when activity, sex, or goal changes, and complete reset.
- Safety handling: under-18 users are not given adult BMI classifications or calorie targets.
- Safety handling: gradual-loss targets are suppressed when an adult BMI result is underweight; unusable BMR results are not shown.
- Responsive Material 3 layout, system light/dark themes, SDG 3 information, and health disclaimer.
- All calculations happen locally; no account, backend, or network is needed.

## Technology

Flutter, Dart (null safety), Material 3, Flutter test.

## Project structure

```text
lib/
  app.dart
  main.dart
  models/calculator_result.dart
  screens/ (home, calculator, about)
  services/ (calculations and validation)
  theme/app_theme.dart
  widgets/ (form controls, results, BMI indicator)
test/ (service unit tests and widget tests)
docs/ (report, user manual, testing report, VEDIC summary)
```

Flutter-generated Android, iOS, Windows, macOS, Linux, and web runner files are included.

## Screenshots

Add genuine screenshots from a running build to `docs/screenshots/` before submission. No screenshots are included yet.

## Setup and run

Install the current stable Flutter SDK and add its `bin` directory to PATH (this environment used `C:\flutter\bin`). Verify it with `flutter doctor`. Then, from the project directory:

```sh
flutter pub get
flutter run
```

Run checks:

```sh
dart format .
flutter analyze
flutter test
```

## Build targets

```sh
flutter build web --release
flutter build apk --release
flutter build windows --release
flutter build macos --release
flutter build linux --release
flutter build ios --release
```

Android requires Android SDK/build tools; iOS and macOS require macOS and Xcode; Windows requires Windows desktop build tools; Linux requires Linux development packages; web needs Flutter web support. Builds must run on a compatible host.

## Verification status

Verified with Flutter 3.41.4 and Dart 3.11.1: formatting passed, `flutter analyze` reported no issues, and all 14 unit/widget tests passed. The web release build succeeded at `build/web`. Android APK build is blocked by a malformed NDK installation and missing Android command-line setup. Windows build is blocked by the missing Visual Studio C++ workload. See [testing report](docs/testing_report.md) for details.

## Health and privacy

BMI is a screening measure and does not distinguish muscle from fat or account for every individual factor. Calorie estimates are approximate, based on a selected BMR equation and activity level. This app is for general education and does not provide medical advice. Data is processed in memory and is not transmitted or persisted.

## GitHub submission

Repository: [rajarapuharsha/Flutter-proj](https://github.com/rajarapuharsha/Flutter-proj). Push the project to the `main` branch to trigger the workflow in `.github/workflows/deploy.yml`. It runs analysis and tests, builds Flutter web with the repository base path, and deploys to GitHub Pages.

```sh
git add .
git commit -m "Complete BMI and calorie calculator project"
git branch -M main
git remote add origin https://github.com/rajarapuharsha/Flutter-proj.git
git push -u origin main
```

Expected Pages URL after the first successful deployment: https://rajarapuharsha.github.io/Flutter-proj/. Confirm the deployment in the repository's Actions tab and enable GitHub Pages from GitHub Actions in Settings → Pages if the workflow is not allowed to configure it automatically.

## Documentation

- [Project report](docs/project_report.md)
- [User manual](docs/user_manual.md)
- [Testing report](docs/testing_report.md)
- [VEDIC portal summary](docs/vedic_submission.md)
