import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class Visitor extends SimpleElementVisitor<void> {
  late String className;

  final List<EntityFieldElement> fields = [];

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    if (elementReturnType.endsWith("Source")) {
      className = elementReturnType.replaceFirst('*', '').replaceFirst('Source', '');
    } else {
      throw Exception('A class annotated with @generateEntity should end in `Source`');
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields.add(EntityFieldElement(
      type: element.type.toString(),
      name: element.name,
    ));
  }
}

class EntityFieldElement {
  final String type;
  final String name;

  EntityFieldElement({
    required this.type,
    required this.name,
  });
}
