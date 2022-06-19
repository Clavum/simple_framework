import 'package:simple_framework/simple_framework.dart';

class TestViewModel extends ViewModel {
  final String value;

  TestViewModel({required this.value});

  @override
  List<Object?> get props => [value];
}
