import 'package:equatable/equatable.dart';

class Model extends Equatable {
  @override
  bool get stringify => true;

  const Model();

  Model merge() {
    return const Model();
  }

  @override
  List<Object?> get props => [];
}
