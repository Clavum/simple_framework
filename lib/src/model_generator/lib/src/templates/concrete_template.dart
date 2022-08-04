import 'package:model_generator/src/model.dart';

class ConcreteTemplate {
  final Model model;

  ConcreteTemplate(this.model);

  @override
  String toString() {
    String generatedWarning = '';
    if (model.parameters.isNotEmpty) {
      generatedWarning = '// GENERATED CODE - DO NOT MODIFY BY HAND';
    }

    final StringBuffer mergeBuffer = StringBuffer();
    final String maybeLeftBrace = model.parameters.isEmpty ? '' : '{';
    final String maybeRightBrace = model.parameters.isEmpty ? '' : '}';
    if (model.options.shouldGenerateMerge) {
      mergeBuffer.writeln(
        '''
// GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  ${model.abstractClassName} merge($maybeLeftBrace
    ${model.nullableParameterList()}
  $maybeRightBrace) {
    return ${model.abstractClassName}(
      ${model.mergeFieldsList()}
    );
  }

''',
      );
    }

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class ${model.mainClassName} extends ${model.abstractClassName} {
  ${model.collectionDefaults()}

  const ${model.mainClassName}($maybeLeftBrace
    ${model.concreteParameterList()}
  $maybeRightBrace) : super._();

  $generatedWarning
  ${model.parameterOverrides()}

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object?> get props => [
        ${model.parametersWithCommas()}
      ];

  ${mergeBuffer.toString()}
  @override
  Type get runtimeType => ${model.className};
}

''';
  }
}
