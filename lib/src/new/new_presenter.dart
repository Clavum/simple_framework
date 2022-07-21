import 'package:clean_framework_internal/clean_framework_internal.dart';
import 'package:flutter/widgets.dart';

abstract class NewPresenter<B extends NewBloc<V>, V extends ViewModel>
    extends StatefulWidget {
  const NewPresenter({Key? key}) : super(key: key);

  Screen buildScreen(BuildContext context, B bloc, V viewModel);

  Widget buildLoadingScreen(BuildContext context) =>
      Container(key: Key('waitingForStream'));

  Widget buildErrorScreen(BuildContext context, Object? error) =>
      Container(key: Key('noContentFromStream'));

  @override
  State<NewPresenter<B, V>> createState() => _NewPresenterState<B, V>();
}

class _NewPresenterState<B extends NewBloc<V>, V extends ViewModel>
    extends State<NewPresenter<B, V>> {
  late B _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<B>(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<V>(
      stream: _bloc.viewModelStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.buildLoadingScreen(context);
        } else if (snapshot.hasData) {
          return widget.buildScreen(context, _bloc, snapshot.data!);
        }
        return widget.buildErrorScreen(context, snapshot.error);
      },
    );
  }
}
