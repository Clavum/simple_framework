import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class StatelessScreen<B extends Bloc> extends StatefulWidget {
  final B _bloc;

  const StatelessScreen(this._bloc, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc);

  @override
  @nonVirtual
  _ScreenState<B> createState() => _ScreenState<B>();
}

class _ScreenState<B extends Bloc> extends State<StatelessScreen<B>> {
  @override
  void initState() {
    super.initState();
    widget._bloc.onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, widget._bloc);
  }

  @override
  void dispose() {
    super.dispose();
    widget._bloc.onDispose();
  }
}
