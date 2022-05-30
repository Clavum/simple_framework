import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/src/annotation.dart';
import 'package:generators/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

// TODO list:
// Fix not being able to have methods in a model. Generated model has errors because it doesn't
// implement the method.
// Verify user's code syntax is correct for the model.
// Fix generated model has errors when user makes model with no parameters - best way to do this,
// because so much is different when you don't have any parameters, is to check if there's any
// parameters right at the start, and there aren't any, build a special empty model.
// Replace "Entity" text with correct model name. Default to Model.
class ModelGenerator extends GeneratorForAnnotation<GenerateModel> {
  late bool shouldGenerateMerge;
  late bool parametersRequired;
  late bool shouldGenerateGetter;
  final Visitor visitor;
  final StringBuffer buffer;

  ModelGenerator()
      : visitor = Visitor(),
        buffer = StringBuffer();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    shouldGenerateMerge = annotation.read('shouldGenerateMerge').boolValue;
    parametersRequired = annotation.read('parametersRequired').boolValue;
    shouldGenerateGetter = annotation.read('shouldGenerateGetter').boolValue;

    buffer.clear();
    visitor.clear();
    element.visitChildren(visitor);

    generateHeaderInfo();

    MixinGenerator(this).generate();

    MainClassGenerator(this).generate();

    if (shouldGenerateGetter) {
      generateGetter();
    }

    return buffer.toString();
  }

  generateHeaderInfo() {
    buffer.writeln('''
// ignore_for_file: prefer_const_constructors_in_immutables

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed an instance of your Entity using the private constructor, i.e. `Entity._()`. This constructor is only meant to be used by the Entity generator and you are not supposed to use it.');

    ''');
  }

  generateGetter() {
    buffer.writeln('${visitor.className} get ${visitor.camelCaseClassName}'
        ' => Repository().get(${visitor.className}());');
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
_${generator.visitor.className} merge({
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
      if (generator.parametersRequired) {
        constructorParametersBuffer.writeln('required this.${parameter.name},');
      } else {
        constructorParametersBuffer.writeln('this.${parameter.name} = ${parameter.defaultValue},');
      }
    }

    final StringBuffer parameterOverridesBuffer = StringBuffer();
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

    generator.buffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND
/// @nodoc
class _${generator.visitor.className} extends Entity implements ${generator.visitor.className} {
  _${generator.visitor.className}({
    ${constructorParametersBuffer.toString()}
  });

  // GENERATED CODE - DO NOT MODIFY BY HAND
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
