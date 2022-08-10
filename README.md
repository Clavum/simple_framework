## Simple Framework
A code structure and state management framework for Flutter with the goal of simplicity.

## Components

There are four components to the Simple Framework:
 - **Entity** - holds app state
 - **ViewModel** - define how a Screen is created
 - **Screen** - a Widget that builds from a ViewModel
 - **Bloc** - ties the previous three components together

### Entity

**Entities** are model classes which hold app state data. They use code generation (via the annotation
`@generateEntity`) so that defining them is easy.

```dart
@generateEntity
class ExampleEntity extends Entity with _$ExampleEntity {
  const ExampleEntity._();

  const factory ExampleEntity({
    @Default(0) int counter,
  }) = _ExampleEntity;
}
```

The code generator will create a "modifier" named the same as the **Entity**, but in lower camel
case. For the `ExampleEntity` above, it would generate a modifier named `exampleEntity`. You
can use this modifier to quickly access and modify the values in the **Entity**. For example:

```
print(exampleEntity.counter); //0
exampleEntity.counter++;
print(exampleEntity.counter); //1
```

More on this later!

### ViewModel

**ViewModels** are model classes that define the data a **Screen** uses to build. They are created by the
**Bloc** based on one or more **Entities**. **ViewModels** also use code generation, with `@generateViewModel`.

```dart
@generateViewModel
class ExampleViewModel extends ViewModel with _$ExampleViewModel {
  const ExampleViewModel._();

  const factory ExampleViewModel({
    required String counter,
  }) = _ExampleViewModel;
}
```

### Screen

**Screens** are Widgets that build from a **ViewModel**. They are associated with a **Bloc** which will
provide the **ViewModels**.

```dart
class ExampleScreen extends Screen<ExampleBloc> {
  ExampleScreen() : super(ExampleBloc());

  @override
  Widget build(context, bloc, viewModel) {
    return ElevatedButton(
      child: Text(viewModel.counter),
      onPressed: bloc.incrementCounter,
    );
  }
}
```

### Bloc

A **Bloc** is a class which updates **Entities** based on user interaction.

The `buildViewModel` method isn't as simple as it seems...some magic goes on in the background
to recognize (in this example) that the `buildViewModel` method uses the `ExampleEntity`. Then
when `send()` is called on the `ExampleEntity`, the `buildViewModel` method will be called again
and the **Screen** is rebuilt with the new result.

```dart
class ExampleBloc extends Bloc<ExampleViewModel> {
  @override
  ExampleViewModel buildViewModel() {
    return ExampleViewModel(
      example: exampleEntity.counter,
    );
  }

  void incrementCounter() {
    exampleEntity.counter++;
    exampleEntity.send();
  }
}
```

And that's it!
See the `example` folder for the full example of using the Simple Framework to make the classic
Flutter counter app.

### Credits
A huge amount credit goes to the Clean Framework package for being the basis which I tried to
improve upon.
[Clean Framework](https://pub.dev/packages/clean_framework/versions/0.4.2)

I would've never managed to make a decent code generator if it weren't for the Freezed package
being my reference.
[Freezed](https://pub.dev/packages/freezed)
