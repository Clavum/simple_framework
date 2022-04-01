import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc, E extends Entity> extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  Widget buildScreen(BuildContext context, B bloc, E entity);

  @override
  @nonVirtual
  _ScreenState<B, E> createState() => _ScreenState<B, E>();
}

class _ScreenState<B extends Bloc, E extends Entity>
    extends State<Screen<B, E>> {
  late B _bloc;
  late E _entity;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<B>();
    _bloc.entityStream.stream.listen((entity) {
      _entity = entity as E;
      setState(() {});
    });
    _entity = _bloc.entity as E;
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildScreen(context, _bloc, _entity);
  }
}