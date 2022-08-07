import 'package:model_generator/src/model.dart';

class AbstractTemplate {
  final Model model;

  AbstractTemplate(this.model);

  @override
  String toString() {
    String maybeLeftBrace = model.parameters.isNotEmpty ? '{' : '';
    String maybeRightBrace = model.parameters.isNotEmpty ? '}' : '';

    return '''
/// @nodoc
abstract class ${model.abstractClassName} extends ${model.className} {
  const factory ${model.abstractClassName}($maybeLeftBrace
    ${model.redirectedParameterList()}
  $maybeRightBrace) = ${model.mainClassName};

  const ${model.abstractClassName}._() : super._();

  ${model.getterList(useOverride: true)}
}

''';
  }
}
