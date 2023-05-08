import 'package:flutter/material.dart';

class ScrollNotifier extends StatefulWidget {
  const ScrollNotifier({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  _ScrollNotifierState createState() => _ScrollNotifierState();
}

class _ScrollNotifierState extends State<ScrollNotifier> {
  ScrollMetrics? metrics;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        setState(() => metrics = notification.metrics);
        return false;
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
    super.key,
    required this.metrics,
    required super.child,
  });

  final ScrollMetrics? metrics;

  static ScrollMetrics? of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ScrollSettings>();
    return widget?.metrics;
  }

  @override
  bool updateShouldNotify(ScrollSettings oldWidget) =>
      metrics != oldWidget.metrics;
}
