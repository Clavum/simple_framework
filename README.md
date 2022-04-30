A simple code organization and state management framework inspired by the
[Clean Framework](https://pub.dev/packages/clean_framework/versions/0.4.2).

## Components

There are just three components in the Simple Framework:
 - Entities (models which contain the app state, and are stored in the Repository for global use)
 - Screens (widgets that display information based on an Entity)
 - Blocs (classes which have methods triggered by the Screen and update the Entities as needed)

## Entity

Entities are immutable classes which hold state data. To update just one field, you must use the
merge method to get a new instance.

```dart
class ExampleEntity extends Entity {
  final String example;

  const ExampleEntity({
    List<EntityFailure> errors = const [],
    this.example = 'default value',
  }) : super(errors: errors);

  @override
  List<Object> get props => [errors, example];

  @override
  ExampleEntity merge({errors, String? example}) {
    return ExampleEntity(
      errors: errors ?? this.errors,
      example: example ?? this.example,
    );
  }
}
```

## Screen

Each Screen has it's own Bloc, and defines which Entity it builds from. If that Entity is ever
updated in the Repository, the build method will be called.

```dart
class ExampleScreen extends Screen<ExampleBloc> {
  ExampleScreen() : super(ExampleBloc());

  @override
  Widget build(context, bloc, ref) {
    // Get an entity using "ref". If that Entity is updated, the Screen will rebuild and this line
    // will be called again with the latest data.
    ExampleEntity exampleEntity = ref.getEntity(ExampleEntity());

    // Build something here using exampleEntity's data.
    // Call bloc methods when user interacts with components.
    return Container();
  }
}
```

## Bloc

A Bloc is a simple class which updates Entities in the Repository as the Screen is interacted with,
thus rebuilding the Screen with the new Entity.

```dart
class ExampleBloc extends Bloc<ExampleEntity> {
  ExampleBloc() : super(const ExampleEntity());

  void onTapExample() {
    // Using the send() method on an Entity will update Screens that use it.
    entity.merge(example: 'new value').send();
  }
}
```

See the `example` folder for an example of using the Simple Framework to make the classic Counter
app.
