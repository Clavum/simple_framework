import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:model_generator/src/model.dart';
import 'package:model_generator/src/model_visitor.dart';

class Validator {
  void assertValidAnnotatedElement(Element element, Model model) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '${model.options.annotationName} was used on an object other than a class',
        element: element,
      );
    }
  }

  void assertValidParameter(ParameterElement element, Model model) {
    if (!element.isNamed) {
      throw InvalidGenerationSourceError(
        'Generation for ${model.className} failed.\n'
        'All parameters must be named parameters (with curly braces).\n',
        element: element,
      );
    }
  }

  void assertNoMissingRequirements(ModelVisitor visitor, Model model) {
    if (visitor.missingRequirements.isEmpty) {
      return;
    }
    StringBuffer errorBuffer = StringBuffer();

    errorBuffer.writeln('Invalid syntax for generated model: ${model.className}');

    if (visitor.missingRequirements.contains(SyntaxRequirements.extendsRequiredClass)) {
      errorBuffer.writeln();
      errorBuffer.write('${model.className} must extend ${model.options.mustExtend}');
      errorBuffer.writeln(' if it is annotated with ${model.options.annotationName}.');
    }
    if (visitor.missingRequirements.contains(SyntaxRequirements.hasPrivateConstructor)) {
      errorBuffer.writeln();
      errorBuffer.writeln('Missing a valid const private constructor. You must have:');
      errorBuffer.writeln('const ${model.className}._();');
    }
    if (visitor.missingRequirements.contains(SyntaxRequirements.hasFactoryConstructor)) {
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

  void assertNoInvalidParameters(Model model) {
    if (model.invalidParameters().isEmpty) {
      return;
    }
    throw InvalidGenerationSourceError(
      '''
Invalid syntax for generated model: ${model.className}

Every parameter's syntax must either be in one of these forms:

1. required Type parameterName
2. @Default(defaultValue) Type parameterName
3. Type? parameterName

Parameters with invalid syntax:
${model.invalidParameters().map((parameter) => parameter.name).join(',\n')}

''',
      element: model.annotatedElement,
    );
  }

  void assertNoRequiredParameters(Model model) {
    if (model.requiredParameters().isEmpty) {
      return;
    }
    throw InvalidGenerationSourceError(
      '''
Invalid syntax for generated model: ${model.className}

You cannot use a required parameter when using ${model.options.annotationName}.
''',
      element: model.annotatedElement,
    );
  }
}
