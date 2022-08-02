import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/model_visitor.dart';
import 'package:model_generator_annotation/model_generator_annotation.dart' show GenerateModel;
import 'package:source_gen/source_gen.dart';

class ModelGenerator extends GeneratorForAnnotation<GenerateModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final String annotationName = annotation.read('annotationName').stringValue;
    final bool shouldGenerateMerge = annotation.read('shouldGenerateMerge').boolValue;
    final bool shouldGenerateGetter = annotation.read('shouldGenerateGetter').boolValue;
    final bool shouldGenerateSetters = annotation.read('shouldGenerateSetters').boolValue;
    final String? mustExtend = annotation.read('mustExtend').stringValue;

    final ModelVisitor visitor = ModelVisitor();
    final StringBuffer buffer = StringBuffer();
    final Model visitedModel = visitor.getModelFromElement(
      element: element,
      annotationName: annotationName,
      mustExtend: mustExtend,
    );

    if (visitor.missingRequirements.isNotEmpty) {
      _throwMissingSyntaxRequirementsException(
        visitedModel,
        visitor.missingRequirements,
      );
    }

    if (visitedModel.invalidParameters().isNotEmpty) {
      _throwInvalidParameterException(visitedModel);
    }

    buffer.writeln(bypassError(visitedModel));

    String mixinString = MixinGenerator.generate(
      visitedModel,
      shouldGenerateMerge,
      shouldGenerateSetters,
    );
    buffer.writeln(mixinString);

    String mainClassString = MainClassGenerator.generate(
      visitedModel,
      shouldGenerateMerge,
      shouldGenerateSetters,
    );
    buffer.writeln(mainClassString);

    String abstractClassString = AbstractClassGenerator.generate(visitedModel);
    buffer.writeln(abstractClassString);

    if (shouldGenerateGetter) {
      String modifierClassString = ModifierClassGenerator.generate(visitedModel);
      buffer.writeln(modifierClassString);
    }

    return buffer.toString();
  }

  String bypassError(Model model) {
    return '''
final ${model.bypassError} = UnsupportedError(
  '${model.className}\\'s constructor was bypassed by another constructor.',
);

''';
  }
}

class MixinGenerator {
  static String generate(Model model, bool shouldGenerateMerge, bool shouldGenerateSetters) {
    final StringBuffer mergeBuffer = StringBuffer();
    final String maybeLeftBrace = model.parameters.isEmpty ? '' : '{';
    final String maybeRightBrace = model.parameters.isEmpty ? '' : '}';
    if (shouldGenerateMerge) {
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
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin ${model.mixinName} {
  ${model.getterList(returnValue: 'throw ${model.bypassError}')}
  ${mergeBuffer.toString()}

  List<Object?> get props => throw ${model.bypassError};
}

''';
  }
}

class MainClassGenerator {
  static String generate(Model model, bool shouldGenerateMerge, bool shouldGenerateSetters) {
    String generatedWarning = '';
    if (model.parameters.isNotEmpty) {
      generatedWarning = '// GENERATED CODE - DO NOT MODIFY BY HAND';
    }

    final StringBuffer mergeBuffer = StringBuffer();
    final String maybeLeftBrace = model.parameters.isEmpty ? '' : '{';
    final String maybeRightBrace = model.parameters.isEmpty ? '' : '}';
    if (shouldGenerateMerge) {
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

class AbstractClassGenerator {
  static String generate(Model model) {
    String maybeLeftBrace = model.parameters.isNotEmpty ? '{' : '';
    String maybeRightBrace = model.parameters.isNotEmpty ? '}' : '';

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
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

//TODO: Add a merge method for quickly setting multiple fields at once.
//TODO: Right now, I provide a get() method to get the current Entity, so that you can call
//custom methods on it. Ideally, you should be able to call methods directly on the Modifier, but
//this would involve visiting every method and it's parameters, then generating:
//ReturnType methodName(ParameterType parameterName) => _model.methodName(parameterName);
//But then what about if the Model mixins a class? Not allowed, I guess...
class ModifierClassGenerator {
  static String generate(Model model) {
    if (model.requiredParameters().isNotEmpty) {
      _throwGetterWithRequiredParamsException(model);
    }
    return '''
${model.modifierClassName} get ${model.camelCaseName} => ${model.modifierClassName}();

// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class ${model.modifierClassName} {
  ${model.className} get _model => Repository().get(const ${model.className}());

  void send() => Repository().sendModel(_model);

  void set(${model.className} model) => Repository().set(model);

  ${model.className} get() => _model;

  ${model.modifierParameterList()}
  ${model.hasDartCoreCollection ? _generateProcess(model) : ''}
}
    ''';
  }

  static String _generateProcess(Model model) {
    return '''
E _process<E extends Object>(E object) {
  ${model.processParameterConversions()}
  return object;
}
    ''';
  }
}

void _throwMissingSyntaxRequirementsException(
  Model model,
  List<SyntaxRequirements> missingRequirements,
) {
  StringBuffer errorBuffer = StringBuffer();

  errorBuffer.writeln('Invalid syntax for generated model: ${model.className}');

  if (missingRequirements.contains(SyntaxRequirements.extendsRequiredClass)) {
    errorBuffer.writeln();
    errorBuffer.write('${model.className} must extend ${model.mustExtend}');
    errorBuffer.writeln(' if it is annotated with ${model.annotationName}.');
  }
  if (missingRequirements.contains(SyntaxRequirements.hasPrivateConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a valid const private constructor. You must have:');
    errorBuffer.writeln('const ${model.className}._();');
  }
  if (missingRequirements.contains(SyntaxRequirements.hasFactoryConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a const factory constructor:');
    errorBuffer.writeln(
      '''
const factory ${model.className}({
  ...your fields
}) = _${model.className};
''',
    );
  }

  throw InvalidGenerationSourceError(
    errorBuffer.toString(),
    element: model.annotatedElement,
  );
}

void _throwInvalidParameterException(Model model) {
  StringBuffer invalidParametersBuffer = StringBuffer();
  for (var parameter in model.invalidParameters()) {
    invalidParametersBuffer.writeln(parameter.name);
  }

  throw InvalidGenerationSourceError(
    '''
Invalid syntax for generated model: ${model.className}

Every parameter's syntax must either be in one of these forms:

1. required Type parameterName
2. @Default(defaultValue) Type parameterName
3. Type? parameterName

Parameters with invalid syntax:
${invalidParametersBuffer.toString()}
''',
    element: model.annotatedElement,
  );
}

void _throwGetterWithRequiredParamsException(Model model) {
  throw InvalidGenerationSourceError(
    '''
Invalid syntax for generated model: ${model.className}

You cannot use a required parameter when using ${model.annotationName}.
''',
    element: model.annotatedElement,
  );
}
