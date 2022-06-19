import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc, V extends ViewModel> extends StatefulWidget {
  final B _bloc;

  final ModelBuilder<V> _builder;

  const Screen(this._bloc, this._builder, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc, V viewModel);

  Widget buildLoadingScreen(BuildContext context, B bloc) {
    return const SizedBox.shrink();
  }

  @visibleForTesting
  @nonVirtual
  B get debugGetBloc => _bloc;

  @override
  @nonVirtual
  _ScreenState<B, V> createState() => _ScreenState<B, V>();
}

class _ScreenState<B extends Bloc, V extends ViewModel> extends State<Screen<B, V>> {
  late ScreenRef _ref;

  V? _viewModel;

  final Map<Type, StreamSubscription<void>> _streams = {};

  bool loading = true;

  @override
  void initState() {
    super.initState();
    setUpRef();

    awaitBuilder();
  }

  /// A loading screen will be shown until the builder is done loading.
  void awaitBuilder() async {
    await widget._bloc.onCreate();
    _viewModel = await widget._builder.build(_ref);
    _ref.firstLoad = false;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return widget.buildLoadingScreen(context, widget._bloc);
    } else {
      return widget.build(context, widget._bloc, _viewModel!);
    }
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

  void setUpRef() {
    _ref = ScreenRef(<T extends RepositoryModel>() {
      _streams[T] ??= Repository().streamOf<T>().listen((entity) async {
        var nextViewModel = await widget._builder.build(_ref);
        if (nextViewModel != _viewModel) {
          setState(() {
            _viewModel = nextViewModel;
          });
        }
      });
    });
  }
}
