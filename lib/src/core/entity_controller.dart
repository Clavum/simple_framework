import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

class EntityController<E extends Entity> {
  /// This method will be called when the [Entity] is not in the [Repository] yet, meaning it has
  /// not yet been initialized. Use this to call some method which will fetch the information needed
  /// for the [Entity] and update it (preferably send() it so that the [Screen] will update).
  ///
  /// It is suggested, in this case, to add some sort of 'initialized' parameter to the [Entity],
  /// which is false by default, to avoid loading the [Screen] with the default [Entity] data before
  /// the [loader] has completed.
  Future<E> Function()? loader;

  /// After this duration of time, the [loader] will be called again. This happens indefinitely.
  /// Use this to refresh a Widget without user interaction.
  Duration? refreshPeriod;

  /// If the [Screen] which holds this [EntityController] is disposed, this determines if the
  /// [Entity] should be reset. This effectively accomplishes the same thing as state management
  /// solutions like Provider by having data tied to the widget tree.
  bool clearOnDispose;

  final List<Timer> _refreshTimers = [];

  EntityController({
    this.loader,
    this.refreshPeriod,
    this.clearOnDispose = false,
  });

  Future<void> initialize({required VoidCallback updateViewModelCallback}) async {
    _callLoader(onlyIfEmpty: true);

    if (refreshPeriod != null) {
      _refreshTimers.add(Timer.periodic(
        refreshPeriod!,
        (_) async {
          await _callLoader();
          updateViewModelCallback();
        },
      ));
    }
  }

  Future<void> _callLoader({bool onlyIfEmpty = false}) async {
    if (loader != null) {
      E entity = await loader!();
      Repository().set<E>(entity);
    }
  }

  void onDispose() {
    if (clearOnDispose) {
      Repository().removeEntity<E>();
    }

    for (var timer in _refreshTimers) {
      timer.cancel();
    }
  }
}
