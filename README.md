# nas_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Active intl_utils before run next command
```bash
flutter pub global activate intl_utils
```
Run:
```bash
flutter --no-color pub global run intl_utils:generate
```

## Run and release flavor dev
``` bash
flutter run --flavor dev -t lib/main.dart
flutter build apk --release --flavor dev -t lib/main.dart
flutter build appbundle --release --flavor dev -t lib/main.dart 
flutter build ipa --release --flavor dev -t lib/main.dart
flutter build web --release -t lib/main.dart

```

## Run and release flavor prod
``` bash
flutter run --flavor prod -t lib/main_prod.dart
flutter build apk --release --flavor prod -t lib/main_prod.dart
flutter build appbundle --release --flavor prod -t lib/main_prod.dart
flutter build ipa --release --flavor prod -t lib/main_prod.dart
flutter build web --release -t lib/main_prod.dart
```
## Run build launcher icon
``` bash
dart run flutter_launcher_icons
```

