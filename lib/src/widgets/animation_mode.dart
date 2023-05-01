import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimationMode extends InheritedWidget {
  const AnimationMode({
    super.key,
    required this.enabled,
    required super.child,
  });

  final bool enabled;

  static bool of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AnimationMode>();
    return widget?.enabled ?? true;
  }

  @override
  bool updateShouldNotify(AnimationMode oldWidget) =>
      enabled != oldWidget.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'mode',
        value: enabled,
        ifTrue: 'enabled',
        ifFalse: 'disabled',
        showName: true,
      ),
    );
  }
}
