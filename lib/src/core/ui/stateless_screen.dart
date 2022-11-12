part of '../core.dart';

abstract class StatelessScreen<B extends Bloc> extends StatefulWidget {
  const StatelessScreen({super.key});

  Widget build(BuildContext context, B bloc);

  B createBloc();

  @override
  @nonVirtual
  State<StatelessScreen<B>> createState() => _ScreenState<B>();
}

class _ScreenState<B extends Bloc> extends State<StatelessScreen<B>> {
  late final B bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.createBloc()..onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, bloc);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.onDispose();
  }
}
