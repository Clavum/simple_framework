import 'package:model_generator/src/model.dart';

class MixinTemplate {
  final Model model;

  MixinTemplate(this.model);

  @override
  String toString() {
    final StringBuffer mergeBuffer = StringBuffer();
    final String maybeLeftBrace = model.parameters.isEmpty ? '' : '{';
    final String maybeRightBrace = model.parameters.isEmpty ? '' : '}';
    if (model.options.shouldGenerateMerge) {
      mergeBuffer.writeln(
        '''
${model.className} merge($maybeLeftBrace
    ${model.nullableParameterList()}
  $maybeRightBrace) {
    throw ${model.bypassError};
  }
''',
      );
    }

    return '''
/// @nodoc
mixin ${model.mixinName} {
  ${model.getterList(returnValue: 'throw ${model.bypassError}')}

  ${(model.options.shouldGenerateModifier) ? model.setterList(returnValue: 'throw ${model.bypassError}') : ''}

  ${mergeBuffer.toString()}

  List<Object?> get props => throw ${model.bypassError};
}

''';
  }
}
