part of '../core.dart';

abstract class StatelessPresenter<B extends StatelessBloc> extends StatelessWidget {
  const StatelessPresenter({super.key});

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return buildWidget(context, createBloc());
  }

  Widget buildWidget(BuildContext context, B bloc);

  B createBloc();
}
