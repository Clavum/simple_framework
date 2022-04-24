import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:entity_generator/src/annotation.dart';
import 'package:entity_generator/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

class EntityGenerator extends GeneratorForAnnotation<EntityAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = Visitor();
    element.visitChildren(visitor);
    final buffer = StringBuffer();

    if (visitor.fields.isEmpty) {
      throw Exception('A class annotated with @generateEntity should have at least one field');
    }

    buffer.writeln('class ${visitor.className} extends Entity {');

    generateFields(visitor, buffer);
    buffer.writeln();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    generateConstructor(visitor, buffer);
    buffer.writeln();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    generateProps(visitor, buffer);
    buffer.writeln();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    generateMerge(visitor, buffer);

    buffer.writeln('}');

    return buffer.toString();
  }

  void generateFields(Visitor visitor, StringBuffer buffer) {
    for (EntityFieldElement field in visitor.fields) {
      buffer.writeln('final ${field.type} ${field.name};');
    }
  }

  void generateConstructor(Visitor visitor, StringBuffer buffer) {
    buffer.writeln('${visitor.className}({');
    buffer.writeln('List<EntityFailure> errors = const [],');
    for (EntityFieldElement field in visitor.fields) {
      buffer.writeln('${field.type}? ${field.name},');
    }

    buffer.writeln('})  : ');
    for (EntityFieldElement field in visitor.fields) {
      buffer.write('${field.name} = ${field.name} ?? ');
      buffer.write('${visitor.className}Source().${field.name},\n');
    }
    buffer.writeln('super(errors: errors);');
  }

  void generateProps(Visitor visitor, StringBuffer buffer) {
    buffer.writeln('@override');
    buffer.writeln('List<Object> get props => [');
    buffer.writeln('errors,');
    for (EntityFieldElement field in visitor.fields) {
      buffer.writeln('${field.name},');
    }
    buffer.writeln('];');
  }

  void generateMerge(Visitor visitor, StringBuffer buffer) {
    buffer.writeln('@override');
    buffer.writeln('${visitor.className} merge({');
    buffer.writeln('List<EntityFailure>? errors,');
    for (EntityFieldElement field in visitor.fields) {
      buffer.writeln('${field.type}? ${field.name},');
    }
    buffer.writeln('}) {');
    buffer.writeln('return ${visitor.className}(');
    for (EntityFieldElement field in visitor.fields) {
      buffer.writeln('${field.name}: ${field.name} ?? this.${field.name},');
    }
    buffer.writeln(');');
    buffer.writeln('}');
  }
}
