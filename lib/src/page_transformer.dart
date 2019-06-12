import 'package:flutter_web/material.dart';

class ScrollNotifier extends StatefulWidget {
  const ScrollNotifier({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _ScrollNotifierState createState() => _ScrollNotifierState();
}

class _ScrollNotifierState extends State<ScrollNotifier> {
  ScrollMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        setState(() => metrics = notification.metrics);
      },
      child: ScrollSettings(
        metrics: metrics,
        child: widget.child,
      ),
    );
  }
}

class ScrollSettings extends InheritedWidget {
  const ScrollSettings({
    Key key,
    @required this.metrics,
    @required Widget child,
  }) : super(key: key, child: child);

  final ScrollMetrics metrics;

  static ScrollMetrics of(BuildContext context) {
    final ScrollSettings widget =
        context.inheritFromWidgetOfExactType(ScrollSettings);
    return widget?.metrics;
  }

  @override
  bool updateShouldNotify(ScrollSettings oldWidget) =>
      metrics != oldWidget.metrics;
}
