Code generation cannot be simply tested with `flutter test`. To run the tests in this package, you must:


1. Run `dart run build_runner test -- "test/failure_test.dart"` to run failure_test.dart

2. Run `flutter pub run build_runner build --delete-conflicting-outputs` to update generated models.
    - If an exception is printed from the generator, there is something wrong with the code.

3. Run `flutter test -x failure` to run every test excluding failure_test.dart
