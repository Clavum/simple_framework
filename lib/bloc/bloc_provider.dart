import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_framework/simple_framework.dart';

extension BlocProviderExtension on BuildContext {
  B bloc<B extends Bloc>() => Provider.of<B>(this, listen: false);
}

/// If provider of same type is found above [BlocProvider],
/// new instance won't be create. i.e. [create] will be ignored.
class BlocProvider<B extends Bloc> extends StatefulWidget {
  final B Function(BuildContext) create;
  final Widget child;

  const BlocProvider({
    Key? key,
    required this.create,
    required this.child,
  }) : super(key: key);

  static of<B extends Bloc>(BuildContext context) => Provider.of<B>(context, listen: false);

  @override
  _BlocProviderState createState() => _BlocProviderState<B>();
}

class _BlocProviderState<B extends Bloc> extends State<BlocProvider<B>> {
  B? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bloc == null) {
      try {
        _bloc = context.read<B>();
      } on ProviderNotFoundException catch (_) {
        _bloc = widget.create(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<B>(
      create: (_) => _bloc!,
      child: widget.child,
      dispose: (_, __) => _bloc!.dispose(),
    );
  }
}
