export 'package:collection/collection.dart' show DeepCollectionEquality;

class EntityAnnotation {
  const EntityAnnotation();
}

const generateEntity = EntityAnnotation();

/// Allows using `@Default('value')` on a parameter to provide a default value.
class Default {
  const Default(this.defaultValue);

  final Object? defaultValue;
}