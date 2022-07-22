import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

abstract class Screen<B extends Bloc<V>, V extends ViewModel> extends StatefulWidget {
  final B _bloc;

  const Screen(this._bloc, {Key? key}) : super(key: key);

  Widget build(BuildContext context, B bloc, V viewModel);

  Widget buildLoadingScreen(BuildContext context, B bloc) {
    return const SizedBox.shrink(key: Key('waitingForStream'));
  }

  @visibleForTesting
  @nonVirtual
  B get debugGetBloc => _bloc;

  @override
  @nonVirtual
  _ScreenState<B, V> createState() => _ScreenState<B, V>();
}

class _ScreenState<B extends Bloc<V>, V extends ViewModel> extends State<Screen<B, V>> {
  @override
  void initState() {
    super.initState();
    widget._bloc.onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<V>(
      stream: widget._bloc.viewModelStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.buildLoadingScreen(context, widget._bloc);
        } else if (snapshot.hasData) {
          return widget.build(context, widget._bloc, snapshot.data!);
        }
        return const SizedBox.shrink(key: Key('errorFromStream'));
      },
    );
  }

  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }
}
