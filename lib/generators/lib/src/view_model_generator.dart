import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/src/annotation.dart';
import 'package:generators/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class ViewModelGenerator extends GeneratorForAnnotation<ViewModelAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = Visitor();
    element.visitChildren(visitor);
    final buffer = StringBuffer();

    buffer.writeln('// ignore_for_file: prefer_const_constructors_in_immutables');
    buffer.writeln();

    buffer.writeln('''
final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed an instance of your Entity using the private constructor, i.e. `Entity._()`. This constructor is only meant to be used by the Entity generator and you are not supposed to use it.');

    ''');

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    generateMixin(visitor, buffer);
    buffer.writeln();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('/// @nodoc');
    buffer.writeln('class _${visitor.className} extends Entity implements ${visitor.className} {');
    generateConstructor(visitor, buffer);
    buffer.writeln();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    generateOverrideParameters(visitor, buffer);
    buffer.writeln();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    generateProps(visitor, buffer);
    buffer.writeln();

    buffer.writeln('@override');
    buffer.writeln('Type get runtimeType => ${visitor.className};');

    buffer.writeln('}');

    return buffer.toString();
  }

  void generateMixin(Visitor visitor, StringBuffer buffer) {
    buffer.writeln('/// @nodoc');
    buffer.writeln('mixin _\$${visitor.className} {');
    for (var parameter in visitor.parameters) {
      buffer.writeln(
          '${parameter.type} get ${parameter.name} => throw _privateConstructorUsedError;');
      buffer.writeln();
    }
    buffer.writeln('}');
  }

  void generateConstructor(Visitor visitor, StringBuffer buffer) {
    buffer.writeln('_${visitor.className}({');
    for (var parameter in visitor.parameters) {
      buffer.writeln('this.${parameter.name} = ${parameter.defaultValue},');
    }
    buffer.writeln('});');
  }

  void generateOverrideParameters(Visitor visitor, StringBuffer buffer) {
    for (var parameter in visitor.parameters) {
      buffer.writeln('@override');
      buffer.writeln('final ${parameter.type} ${parameter.name};');
    }
  }

  void generateProps(Visitor visitor, StringBuffer buffer) {
    buffer.writeln('@override');
    buffer.writeln('List<Object> get props => [');
    buffer.writeln('errors,');
    for (var parameter in visitor.parameters) {
      buffer.writeln('${parameter.name},');
    }
    buffer.writeln('];');
  }
}
