//ignore_for_file: unused_element

import 'package:model_generator_annotation/model_generator_annotation.dart';
import 'package:source_gen_test/annotations.dart';

class Entity {
  const Entity();
}

class ViewModel {
  const ViewModel();
}

@ShouldThrow('@generateEntity was used on an object other than a class')
@generateEntity
Object? notAClass;

@ShouldThrow(
  '''
Invalid syntax for generated model: InvalidParameter

Every parameter's syntax must either be in one of these forms:

1. required Type parameterName
2. @Default(defaultValue) Type parameterName
3. Type? parameterName

Parameters with invalid syntax:
value

''',
)
@generateEntity
class InvalidParameter extends Entity {
  const InvalidParameter._();

  const factory InvalidParameter({
    String value,
  }) = _InvalidParameter;
}

class _InvalidParameter implements InvalidParameter {
  const _InvalidParameter({String value = ''});
}

@ShouldThrow(
  '''
Generation for PositionalParameters failed.
All parameters must be named parameters (with curly braces).
''',
)
@generateEntity
class PositionalParameters extends Entity {
  const PositionalParameters._();

  const factory PositionalParameters([
    @Default('') String value,
  ]) = _PositionalParameters;
}

class _PositionalParameters implements PositionalParameters {
  const _PositionalParameters([String value = '']);
}

@ShouldThrow(
  '''
Generation for RequiredParameters failed.
All parameters must be named parameters (with curly braces).
''',
)
@generateEntity
class RequiredParameters extends Entity {
  const RequiredParameters._();

  const factory RequiredParameters(
    @Default('') String value,
  ) = _RequiredParameters;
}

class _RequiredParameters implements RequiredParameters {
  const _RequiredParameters(String value);
}

@ShouldThrow(
  '''
Invalid syntax for generated model: EntityWithRequiredNamedParameters

You cannot use a required parameter when using @generateEntity.
''',
)
@generateEntity
class EntityWithRequiredNamedParameters extends Entity {
  const EntityWithRequiredNamedParameters._();

  const factory EntityWithRequiredNamedParameters({
    required String value,
  }) = _EntityWithRequiredNamedParameters;
}

class _EntityWithRequiredNamedParameters implements EntityWithRequiredNamedParameters {
  const _EntityWithRequiredNamedParameters({required String value});
}

@ShouldThrow(
  '''
Invalid syntax for generated model: MissingFactory

Missing a const factory constructor:
const factory MissingFactory({
  ...your fields
}) = _MissingFactory;

''',
)
@generateEntity
class MissingFactory extends Entity {
  const MissingFactory._();
}

@ShouldThrow(
  '''
Invalid syntax for generated model: MissingPrivateConstructor

Missing a valid const private constructor. You must have:
const MissingPrivateConstructor._();
''',
)
@generateEntity
class MissingPrivateConstructor extends Entity {
  const factory MissingPrivateConstructor({
    @Default('') String value,
  }) = _MissingPrivateConstructor;
}

class _MissingPrivateConstructor implements MissingPrivateConstructor {
  const _MissingPrivateConstructor({String value = ''});
}

@ShouldThrow(
  '''
Invalid syntax for generated model: PrivateParameters

Missing a valid const private constructor. You must have:
const PrivateParameters._();
''',
)
@generateEntity
class PrivateParameters extends Entity {
  const PrivateParameters._(int parameter);

  const factory PrivateParameters({
    @Default('') String value,
  }) = _PrivateParameters;
}

class _PrivateParameters implements PrivateParameters {
  const _PrivateParameters({String value = ''});
}

@ShouldThrow(
  '''
Invalid syntax for generated model: ExtendsWrongClass

ExtendsWrongClass must extend Entity if it is annotated with @generateEntity.
''',
)
@generateEntity
class ExtendsWrongClass extends ViewModel {
  const ExtendsWrongClass._();

  const factory ExtendsWrongClass({
    @Default('') String value,
  }) = _ExtendsWrongClass;
}

class _ExtendsWrongClass implements ExtendsWrongClass {
  const _ExtendsWrongClass({String value = ''});
}

@ShouldThrow(
  '''
Invalid syntax for generated model: ExtendsWrongClass2

ExtendsWrongClass2 must extend ViewModel if it is annotated with @generateViewModel.
''',
)
@generateViewModel
class ExtendsWrongClass2 extends Entity {
  const ExtendsWrongClass2._();

  const factory ExtendsWrongClass2({
    @Default('') String value,
  }) = _ExtendsWrongClass2;
}

class _ExtendsWrongClass2 implements ExtendsWrongClass2 {
  const _ExtendsWrongClass2({String value = ''});
}
