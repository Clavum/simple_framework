part of '../core.dart';

abstract class StatelessScreen<B extends StatelessBloc> extends StatelessWidget {
  const StatelessScreen({super.key});

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return buildScreen(context, createBloc());
  }

  Widget buildScreen(BuildContext context, B bloc);

  B createBloc();
}
