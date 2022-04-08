import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc, E extends Entity> extends StatefulWidget {
  final B _bloc;

  const Screen(this._bloc, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc, E entity);

  @override
  @nonVirtual
  _ScreenState<B, E> createState() => _ScreenState<B, E>();
}

class _ScreenState<B extends Bloc, E extends Entity>
    extends State<Screen<B, E>> {
  late E _entity;

  @override
  void initState() {
    super.initState();
    widget._bloc.onCreate();
    Repository().streamOf<E>().listen((entity) {
      _entity = entity as E;
      setState(() {});
    });
    _entity = widget._bloc.entity as E;
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, widget._bloc, _entity);
  }

  @override
  void dispose() {
    super.dispose();
    widget._bloc.dispose();
  }
}