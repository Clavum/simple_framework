import 'dart:async';
import 'dart:ui';

import 'package:meta/meta.dart';

class Pipe<T> {
  final bool canSendDuplicateData;
  final T? initialData;
  final StreamController<T> _controller;

  bool _hasListeners = false;
  T? _lastData;

  Stream<T> get receive => _controller.stream;

  bool get hasListeners => _hasListeners;

  T? get previousData => _lastData;

  Pipe._({
    StreamController<T>? controller,
    this.initialData,
    this.canSendDuplicateData = false,
  }) : _controller = controller ?? StreamController<T>.broadcast() {
    _controller.onListen = () {
      _hasListeners = true;
    };
  }

  factory Pipe({T? initialData, bool canSendDuplicateData = false}) {
    return Pipe._(
      initialData: initialData,
      canSendDuplicateData: canSendDuplicateData,
    );
  }

  factory Pipe.single({T? initialData, bool canSendDuplicateData = false}) {
    return Pipe._(
      controller: StreamController<T>(),
      initialData: initialData,
      canSendDuplicateData: canSendDuplicateData,
    );
  }

  void whenListenedDo(VoidCallback onListen) {
    _controller.onListen = () {
      _hasListeners = true;
      onListen();
    };
  }

  void dispose() {
    _controller.close();
  }

  bool send(T data) {
    if (_controller.isClosed || (!canSendDuplicateData && _lastData == data)) {
      return false;
    }
    _lastData = data;
    _controller.add(data);
    return true;
  }

  bool throwError(Error error) {
    if (_controller.isClosed) return false;
    _controller.addError(error);
    return true;
  }
}

class EventPipe extends Pipe<void> {
  EventPipe() : super._(initialData: null, canSendDuplicateData: true);

  @override
  @visibleForTesting
  Stream<void> get receive {
    throw StateError(
      "EventPipe isn't intended for receiving data. Use Pipe instead.",
    );
  }

  @override
  @visibleForTesting
  bool send(_) {
    if (_controller.isClosed) return false;
    _controller.add(null);
    return true;
  }

  bool launch() => send(null);

  StreamSubscription<void> listen(void Function() onData, {Function? onError}) {
    return _controller.stream.listen((_) => onData(), onError: onError);
  }
}
