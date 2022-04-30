import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc> extends StatefulWidget {
  final B _bloc;

  const Screen(this._bloc, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc, EntityRef ref);

  @override
  @nonVirtual
  _ScreenState<B> createState() => _ScreenState<B>();
}

class _ScreenState<B extends Bloc> extends State<Screen<B>> {
  late EntityRef ref;

  @override
  void initState() {
    super.initState();
    widget._bloc.onCreate();
    ref = EntityRef(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, widget._bloc, ref);
  }

  @override
  void dispose() {
    super.dispose();
    widget._bloc.dispose();
    ref.close();
  }
}

/// This class is initialized by the ScreenState to allow it to be provided a state callback to
/// update the Screen. This EntityRef will be provided to the Screen's build method so that an
/// Entity can be obtained and the Screen will update if that Entity is sent through the repo.
class EntityRef {
  VoidCallback? stateCallback;

  final Map<Type, StreamSubscription<void>> _streams = {};

  EntityRef(this.stateCallback);

  E getEntity<E extends Entity>(E entity) {
    _streams[E] ??= Repository().streamOf<E>().listen((entity) {
      stateCallback?.call();
    });
    return Repository().get<E>(entity);
  }

  void close() {
    for (var key in _streams.keys) {
      _streams[key]!.cancel();
    }
    stateCallback = null;
  }
}
