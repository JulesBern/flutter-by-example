import 'package:flutter/widgets.dart';

class Provider extends StatefulWidget {
  Provider({data, this.child}) : data = new ValueNotifier(data);

  final ValueNotifier data;
  final Widget child;

  static of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_InheritedProvider)
              as _InheritedProvider)
          .data;

  @override
  createState() => new _ProviderState();
}

class _ProviderState extends State<Provider> {
  @override
  initState() {
    super.initState();
    // Call setState when the ValueNotifier changes
    widget.data.addListener(didValueChange);
  }

  // Wrap setState in a function so the listener can be disposed
  didValueChange() => setState(() {});

  @override
  Widget build(BuildContext context) => new _InheritedProvider(
        data: widget.data,
        child: widget.child,
      );

  @override
  dispose() {
    widget.data.removeListener(didValueChange);
    super.dispose();
  }
}

class _InheritedProvider extends InheritedWidget {
  _InheritedProvider({this.data, Widget child})
      : _dataValue = data.value,
        super(child: child);
  final ValueNotifier data;
  final _dataValue;

  @override
  bool updateShouldNotify(_InheritedProvider oldWidget) =>
      _dataValue != oldWidget._dataValue;
}
