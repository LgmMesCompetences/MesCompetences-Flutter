import 'package:flutter/cupertino.dart';

import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  //Bloc
  final T bloc;

  //Child depending on bloc
  final Widget child;

  //Constructor
  const BlocProvider({Key? key, required this.bloc, required this.child})
      : super(key: key);

  //Config the bloc
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>()!;

    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
