part of '../core.dart';

enum _PresenterStateLifecycle {
  created,
  active,
}

abstract class Presenter<B extends Bloc<V>, V extends ViewModel> extends StatefulWidget {
  const Presenter({super.key});

  Widget build(BuildContext context, B bloc, V viewModel);

  Widget buildLoadingWidget(BuildContext context, B bloc) {
    return const SizedBox.shrink(key: Key('waitingForStream'));
  }

  B createBloc();

  @override
  @nonVirtual
  PresenterState<B, V> createState() => PresenterState<B, V>();
}

class PresenterState<B extends Bloc<V>, V extends ViewModel> extends State<Presenter<B, V>> {
  late final B bloc;

  V? _currentViewModel;

  final StreamController<V> _viewModelStreamController = StreamController<V>(sync: true);

  final Map<Type, StreamSubscription<void>> _entityStreams = {};

  _PresenterStateLifecycle _state = _PresenterStateLifecycle.created;

  @override
  void didChangeDependencies() {
    if (_state == _PresenterStateLifecycle.active) {
      _sendModel();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    bloc = widget.createBloc()..presenterState = this;

    _viewModelStreamController.onListen = () {
      if (_state == _PresenterStateLifecycle.active) _sendModel();
    };

    _createAndSend();
  }

  Future<void> _createAndSend() async {
    await bloc.onCreate();
    unawaited(_sendModel());
    _state = _PresenterStateLifecycle.active;
  }

  Future<void> _sendModel() async {
    Repository()._fetchCallback = _onModelRequested;
    final V nextViewModel = await bloc.buildViewModel();
    Repository()._fetchCallback = null;

    if (bloc.shouldSendNewModel(_currentViewModel, nextViewModel)) {
      _currentViewModel = nextViewModel;
      _viewModelStreamController.add(nextViewModel);
    }
  }

  void _onModelRequested<M extends RepositoryModel>() {
    _entityStreams[M] ??= Repository().streamOf<M>().listen(_onEntityUpdated);
  }

  void _onEntityUpdated(_) => _sendModel();

  @override
  void reassemble() {
    _sendModel();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<V>(
      stream: _viewModelStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.buildLoadingWidget(context, bloc);
        } else if (snapshot.hasData) {
          return widget.build(context, bloc, snapshot.data!);
        }
        return const SizedBox.shrink(key: Key('errorFromStream'));
      },
    );
  }

  @override
  void dispose() {
    for (final subscription in _entityStreams.values) {
      subscription.cancel();
    }
    bloc.onDispose();
    super.dispose();
  }
}
