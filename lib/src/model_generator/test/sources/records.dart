import 'package:simple_framework/simple_framework.dart';

part 'records.model.dart';

// No associated test. This verifies models can build when using records.
@generateModel
class RecordsModel extends Model with _$RecordsModel {
  const RecordsModel._();

  const factory RecordsModel({
    required (int, String, double) record,
  }) = _RecordsModel;
}
