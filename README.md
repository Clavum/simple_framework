A simple code organization and state management framework inspired by the
[Clean Framework](https://pub.dev/packages/clean_framework/versions/0.4.2).

## Components

To create a screen in the Simple Framework, you need just four components:
 - Entity - holds app state
 - ViewModel - define how a Screen is created
 - Screen - a Widget that builds from a ViewModel
 - Bloc - ties the previous three components together

## Entity

Entities are immutable classes which hold app state data. To update an Entity, you can use the
`merge` method (commonly referred to as `copyWith`).

Entities are created with code generation via `@generateEntity`.

```dart
@generateEntity
class ExampleEntity extends Entity with _$ExampleEntity {
  const ExampleEntity._();

  const factory ExampleEntity({
    @Default(0) int counter,
  }) = _ExampleEntity;
}
```

## ViewModel

ViewModels are classes that define how a Screen is created. They are created by the Bloc based on
one or more Entities. ViewModels also use code generation.

```dart
@generateViewModel
class ExampleViewModel extends ViewModel with _$ExampleViewModel {
  const ExampleViewModel._();

  const factory ExampleViewModel({
    required String counter,
  }) = _ExampleViewModel;
}
```

## Screen

Screens are simple Widgets that build from a ViewModel that is provided by the Bloc they are
associated with. The Screen will continuously rebuild as the Bloc provides new ViewModels to
display.

```dart
class ExampleScreen extends Screen<ExampleBloc> {
  ExampleScreen() : super(ExampleBloc());

  @override
  Widget build(context, bloc, viewModel) {
    return ElevatedButton(
      child: Text(viewModel.counter),
      onPressed: () => bloc.incrementCounter(),
    );
  }
}
```

## Bloc

A Bloc is a simple class which updates Entities in the Repository as the Screen is interacted with,
thus rebuilding the Screen with the new Entity.

```dart
class ExampleBloc extends Bloc<ExampleViewModel> {
  @override
  ExampleViewModel buildViewModel() {
    return ExampleViewModel(
      example: exampleEntity.example, // "exampleEntity" is created from the code generator
    );
  }

  void incrementCounter() {
    // Using the send() method on an Entity will cause a new ViewModel to be sent.
    exampleEntity.merge(counter: exampleEntity.counter + 1).send();
  }
}
```

And that's it!
See the `example` folder for a full example of using the Simple Framework to make the classic
Flutter Counter app.

### Credits
A huge amount credit goes to the Clean Framework package for being the basis which I tried to
improve upon.
[Clean Framework](https://pub.dev/packages/clean_framework/versions/0.4.2)

I would've never managed to make a decent code generator if it weren't for the Freezed package
being my reference.
[Freezed](https://pub.dev/packages/freezed)
