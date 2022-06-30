import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/src/annotation.dart';
import 'package:generators/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class ModelGenerator extends GeneratorForAnnotation<GenerateModel> {
  late bool shouldGenerateMerge;
  late bool shouldGenerateGetter;

  late Visitor visitor;
  late StringBuffer buffer;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    shouldGenerateMerge = annotation.read('shouldGenerateMerge').boolValue;
    shouldGenerateGetter = annotation.read('shouldGenerateGetter').boolValue;

    visitor = Visitor();
    buffer = StringBuffer();
    element.visitChildren(visitor);

    if (visitor.missingRequirements.isNotEmpty) {
      throwMissingSyntaxRequirementsException(visitor);
    }

    generateHeaderInfo();

    MixinGenerator(this).generate();

    MainClassGenerator(this).generate();

    AbstractClassGenerator(this).generate();

    if (shouldGenerateGetter) {
      generateGetter();
    }

    return buffer.toString();
  }

  generateHeaderInfo() {
    buffer.writeln('''
// ignore_for_file: prefer_const_constructors_in_immutables, unused_element
// coverage:ignore-file

final _privateConstructorUsedError = UnsupportedError(
    'The Model\\'s factory constructor was bypassed by a private constructor.');

    ''');
  }

  generateGetter() {
    buffer.write('${visitor.className} get ${visitor.camelCaseClassName} ');
    buffer.writeln('=> Repository().get(const ${visitor.className}());');
  }
}

class MixinGenerator {
  final ModelGenerator generator;

  MixinGenerator(this.generator);

  void generate() {
    final StringBuffer parameterGettersBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      parameterGettersBuffer.writeln(
          '${parameter.type} get ${parameter.name} => throw _privateConstructorUsedError;');
      parameterGettersBuffer.writeln();
    }

    final StringBuffer mergeParametersBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      mergeParametersBuffer.writeln('${parameter.type}? ${parameter.name},');
    }

    final StringBuffer mergeBuffer = StringBuffer();
    if (generator.shouldGenerateMerge) {
      mergeBuffer.writeln('''
${generator.visitor.className} merge({
    ${mergeParametersBuffer.toString()}
  }) {
    throw _privateConstructorUsedError;
  }
      ''');
    }

    generator.buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
mixin _\$${generator.visitor.className} {
  ${parameterGettersBuffer.toString()}
  ${mergeBuffer.toString()}
}

    ''');
  }
}

class MainClassGenerator {
  final ModelGenerator generator;

  MainClassGenerator(this.generator);

  void generate() {
    final StringBuffer constructorParametersBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      if (parameter.isRequired) {
        constructorParametersBuffer.writeln('required this.${parameter.name},');
      } else {
        constructorParametersBuffer.writeln('this.${parameter.name} = ${parameter.defaultValue},');
      }
    }

    final StringBuffer parameterOverridesBuffer = StringBuffer();
    if (generator.visitor.parameters.isNotEmpty) {
      parameterOverridesBuffer
          .writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    }
    for (var parameter in generator.visitor.parameters) {
      parameterOverridesBuffer.writeln('@override');
      parameterOverridesBuffer.writeln('final ${parameter.type} ${parameter.name};');
    }

    final StringBuffer propsBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      propsBuffer.writeln('${parameter.name},');
    }

    final StringBuffer mergeParametersBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      mergeParametersBuffer.writeln('${parameter.type}? ${parameter.name},');
    }

    final StringBuffer mergeBodyBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      mergeBodyBuffer.writeln('${parameter.name}: ${parameter.name} ?? this.${parameter.name},');
    }

    final StringBuffer mergeBuffer = StringBuffer();
    if (generator.shouldGenerateMerge) {
      mergeBuffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  _${generator.visitor.className} merge({
    ${mergeParametersBuffer.toString()}
  }) {
    return _${generator.visitor.className}(
      ${mergeBodyBuffer.toString()}
    );
  }

      ''');
    }

    String className = '_\$_${generator.visitor.className}';

    String classDeclaration = 'class $className extends _${generator.visitor.className} {';

    String maybeLeftBrace = generator.visitor.parameters.isNotEmpty ? '{' : '';
    String maybeRightBrace = generator.visitor.parameters.isNotEmpty ? '}' : '';

    generator.buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
$classDeclaration
  const $className($maybeLeftBrace
    ${constructorParametersBuffer.toString()}
  $maybeRightBrace) : super._();

  ${parameterOverridesBuffer.toString()}

  // GENERATED CODE - DO NOT MODIFY BY HAND
  @override
  List<Object> get props => [
        ${propsBuffer.toString()}
      ];

  ${mergeBuffer.toString()}
  @override
  Type get runtimeType => ${generator.visitor.className};
}

    ''');
  }
}

class AbstractClassGenerator {
  final ModelGenerator generator;

  AbstractClassGenerator(this.generator);

  void generate() {
    StringBuffer factoryParametersBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      String required = (parameter.isRequired) ? 'required ' : '';
      factoryParametersBuffer.writeln('$required${parameter.type} ${parameter.name},');
    }

    StringBuffer parameterGettersBuffer = StringBuffer();
    for (var parameter in generator.visitor.parameters) {
      parameterGettersBuffer.writeln('@override');
      parameterGettersBuffer.writeln('${parameter.type} get ${parameter.name};');
      parameterGettersBuffer.writeln();
    }

    String maybeLeftBrace = generator.visitor.parameters.isNotEmpty ? '{' : '';
    String maybeRightBrace = generator.visitor.parameters.isNotEmpty ? '}' : '';

    generator.buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
abstract class _${generator.visitor.className} extends ${generator.visitor.className} {
  const factory _${generator.visitor.className}($maybeLeftBrace
    ${factoryParametersBuffer.toString()}
  $maybeRightBrace) = _\$_${generator.visitor.className};

  const _${generator.visitor.className}._() : super._();

  ${parameterGettersBuffer.toString()}
}

    ''');
  }
}

void throwMissingSyntaxRequirementsException(Visitor visitor) {
  StringBuffer errorBuffer = StringBuffer();

  errorBuffer
      .writeln('Invalid syntax for generated model: ${visitor.className}');

  if (visitor.className.isEmpty) {
    visitor.className = 'ClassName';
  }

  if (visitor.missingRequirements
      .contains(SyntaxRequirements.hasPrivateConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a const private constructor:');
    errorBuffer.writeln('const ${visitor.className}_.();');
  }
  if (visitor.missingRequirements
      .contains(SyntaxRequirements.hasFactoryConstructor)) {
    errorBuffer.writeln();
    errorBuffer.writeln('Missing a const factory constructor:');
    errorBuffer.writeln('''
const factory ${visitor.className}({
  ...your fields
}) = _${visitor.className};
    ''');
  }

  throw Exception(errorBuffer.toString());
}
