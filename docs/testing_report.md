# Testing and Build Report

## Environment status

Checked on 2026-10-27 with Flutter 3.41.4 and Dart 3.11.1 on Windows 11. The SDK was installed at `C:\flutter` but not on PATH, so commands were run using its full path. Flutter platform runners were generated for Android, iOS, web, Windows, macOS, and Linux.

## Automated checks prepared

- `test/calculator_service_test.dart`: BMI formula and category boundaries, invalid inputs, male/female BMR, activity multipliers, maintenance and goal calculations, under-18 behavior, and underweight-goal safety.
- `test/input_validator_test.dart`: valid and invalid age, height, and weight values.
- `test/widget_test.dart`: dashboard navigation, required input validation, calculation results, and reset.

## Reproduce the checks

```sh
flutter pub get
dart format .
flutter analyze
flutter test
flutter build web --release
flutter build apk --release
flutter build windows --release
flutter build macos --release
flutter build linux --release
flutter build ios --release
```

Platform runner folders are already generated. Run remaining builds only on supported operating systems and with the corresponding toolchains. Android can be repaired by installing the Android command-line tools, accepting the Android SDK licenses, and reinstalling a valid NDK through Android Studio SDK Manager; the inspected local NDK folders lacked `source.properties`.

## Current status

| Check | Status |
|---|---|
| Source and tests authored | Yes |
| `flutter pub get` | Passed (also completed during Flutter commands) |
| `dart format .` | Passed: 15 Dart files formatted; final run made no changes |
| `flutter analyze` | Passed: no issues found |
| `flutter test` | Passed: 14 tests |
| `flutter build web --release` | Passed; output at `build/web` |
| `flutter build apk --release` | Failed: local NDK `28.2.13676358` lacks `source.properties`; Flutter reports a malformed NDK download. Flutter Doctor also reports missing Android cmdline-tools and unknown/unaccepted licenses. |
| `flutter build windows --release` | Failed: Visual Studio with Desktop development with C++ is not installed. |
| iOS / macOS builds | Not run: this Windows host cannot build Apple targets; macOS and Xcode are required. |
| Linux build | Not run: Linux host/toolchain required. |
| Screenshots | Not captured yet; add genuine images after running the app for the demonstration. |

Flutter Doctor confirmed Chrome and Edge on the Windows host. Android SDK 36.1.0 was detected, but its toolchain is incomplete. Web release emitted a Cupertino icon font notice and Wasm dry-run suggestion; the build nevertheless succeeded.
