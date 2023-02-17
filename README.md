## Simple Framework
A code structure and state management framework for Flutter with the goal of simplicity.

## Components

There are four components to the Simple Framework:
 - **Entity** - holds app state
 - **ViewModel** - define how a Presenter is created
 - **Presenter** - builds a Widget from a ViewModel
 - **Bloc** - ties the previous three components together

### Entity

**Entities** are model classes which hold app state data. They use code generation (via the annotation
`@generateEntity`) so that defining them is easy.

```dart
@generateEntity
class CounterEntity extends Entity with _$CounterEntity {
  const CounterEntity._();

  const factory CounterEntity({
    @Default(0) int counter,
  }) = _CounterEntity;
}
```

The code generator will create a globally available "modifier" named the same as the **Entity**, but
in lower camel case. For the `CounterEntity` above, it would generate a modifier named
`counterEntity`. You can use this modifier to quickly access and modify entity values. For example:

```
print(counterEntity.counter); // "0"
counterEntity.counter++;

// ...some code far away:

print(counterEntity.counter); // "1"
```

**Note:** This "modifier" does not hold any state; both it and the `CounterEntity` model are
immutable. The only state preserving class in the framework is the **Repository** which holds the
current **Entities**. Getting a value from the modifier is a shortcut for getting the value from
the **Entity** in the **Repository**. Setting a value is a shortcut for setting the **Entity** in
the **Repository** to be a copy of the current **Entity** with the new value.

More on this later! (When I write more documentation, that is.)

### ViewModel

**ViewModels** are model classes that define the data a **Presenter** uses to build. They are created by the
**Bloc** based on one or more **Entities**. **ViewModels** also use code generation, with `@generateViewModel`.

```dart
@generateViewModel
class CounterViewModel extends ViewModel with _$CounterViewModel {
  const CounterViewModel._();

  const factory CounterViewModel({
    required String counter,
  }) = _CounterViewModel;
}
```

### Presenter

**Presenters** are Widgets that build from a **ViewModel**. They are associated with a **Bloc** which will
provide the **ViewModels**.

```dart
class CounterPresenter extends Presenter<CounterBloc, CounterViewModel> {
  @override
  CounterBloc createBloc() => CounterBloc();

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
to recognize (in this example) that the `buildViewModel` method uses the `CounterEntity`. Then
when `send()` is called on the `CounterEntity`, the `buildViewModel` method will be called again
and the **Presenter** is rebuilt with the new result.

```dart
class CounterBloc extends Bloc<CounterViewModel> {
  @override
  CounterViewModel buildViewModel() {
    return CounterViewModel(
      example: counterEntity.counter.toString(),
    );
  }

  void incrementCounter() {
    counterEntity.counter++;
    counterEntity.send();
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
