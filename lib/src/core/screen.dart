import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc, V extends ViewModel> extends StatefulWidget {
  final B _bloc;

  final ViewModelBuilder<V> _builder;

  const Screen(this._bloc, this._builder, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc, V viewModel);

  @override
  @nonVirtual
  _ScreenState<B, V> createState() => _ScreenState<B, V>();
}

class _ScreenState<B extends Bloc, V extends ViewModel> extends State<Screen<B, V>> {
  late EntityRef _ref;
  late V _viewModel;

  V? _previousViewModel;

  final Map<Type, StreamSubscription<void>> _streams = {};

  @override
  void initState() {
    super.initState();
    widget._bloc.onCreate();
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
    _viewModel = widget._builder.build(_ref);
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, widget._bloc, _viewModel);
  }

  @override
  void dispose() {
    super.dispose();
    widget._bloc.dispose();
    for (var key in _streams.keys) {
      _streams[key]!.cancel();
    }
    _ref.close();
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