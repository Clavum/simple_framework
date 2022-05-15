import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc, V extends ViewModel> extends StatefulWidget {
  final B _bloc;

  final ViewModelBuilder<V> _builder;

  final List<EntityScope> scopes = const [];

  const Screen(this._bloc, this._builder, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc, V viewModel);

  Widget buildLoadingScreen(BuildContext context, B bloc) {
    return const SizedBox.shrink();
  }

  @override
  @nonVirtual
  _ScreenState<B, V> createState() => _ScreenState<B, V>();
}

class _ScreenState<B extends Bloc, V extends ViewModel> extends State<Screen<B, V>> {
  late EntityRef _ref;
  late V _viewModel;
  final List<Timer> refreshTimers = [];

  V? _previousViewModel;

  final Map<Type, StreamSubscription<void>> _streams = {};

  bool loading = true;

  @override
  void initState() {
    super.initState();
    setUpScopes();

    widget._bloc.onCreate();
    setUpRef();
    _viewModel = widget._builder.build(_ref);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return widget.buildLoadingScreen(context, widget._bloc);
    } else {
      return widget.build(context, widget._bloc, _viewModel);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget._bloc.dispose();

    /// Cancel streams;
    for (var key in _streams.keys) {
      _streams[key]!.cancel();
    }

    /// Invalidate ref.
    _ref.close();

    /// Cancel timers.
    for (var timer in refreshTimers) {
      timer.cancel();
    }

    /// Trigger scope clear.
    for (var scope in widget.scopes) {
      scope.maybeClear();
    }
  }

  void setUpScopes() async {
    for (var scope in widget.scopes) {
      await scope.maybeLoad();
      if (scope.refreshPeriod != null) {
        refreshTimers.add(Timer.periodic(scope.refreshPeriod!, (_) => scope.loader?.call()));
      }
    }
    setState(() {
      loading = false;
    });
  }

  void setUpRef() {
    _ref = EntityRef(<E extends Entity>() {
      _streams[E] ??= Repository().streamOf<E>().listen((entity) {
        var nextViewModel = widget._builder.build(_ref);
        if (nextViewModel != _previousViewModel) {
          setState(() {
            _previousViewModel = _viewModel;
            _viewModel = nextViewModel;
          });
        }
      });
    });
  }
}

class EntityRef {
  void Function<E extends Entity>()? streamCallback;

  EntityRef(this.streamCallback);

  E getEntity<E extends Entity>(E entity) {
    if (streamCallback != null) {
      streamCallback!<E>();
    }
    return Repository().get<E>(entity);
  }

  void close() {
    streamCallback = null;
  }
}
