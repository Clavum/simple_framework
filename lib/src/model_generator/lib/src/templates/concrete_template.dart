import 'package:model_generator/src/model.dart';

class ConcreteTemplate {
  final Model model;

  ConcreteTemplate(this.model);

  @override
  String toString() {
    final StringBuffer mergeBuffer = StringBuffer();
    final String maybeLeftBrace = model.parameters.isEmpty ? '' : '{';
    final String maybeRightBrace = model.parameters.isEmpty ? '' : '}';
    if (model.options.shouldGenerateMerge) {
      mergeBuffer.writeln(
        '''
  @override
  ${model.abstractClassName} merge($maybeLeftBrace
    ${model.mergeListWithSentinel()}
  $maybeRightBrace) {
    return ${model.abstractClassName}(
      ${model.mergeFieldsList()}
    );
  }

''',
      );
    }

    return '''
/// @nodoc
class ${model.mainClassName} extends ${model.abstractClassName} {
  ${model.collectionDefaults()}

  const ${model.mainClassName}($maybeLeftBrace
    ${model.concreteParameterList()}
  $maybeRightBrace) : super._();

  ${model.parameterOverrides()}

  @override
  List<Object?> get props => [
        ${model.parametersWithCommas()}
      ];

  $mergeBuffer
  @override
  Type get runtimeType => ${model.className};
}

''';
  }
}
