import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:presentation/src/page_transformer.dart';
import 'package:presentation/src/presentation.dart';

class RotateWidget extends StatelessWidget {
  const RotateWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final result = ScrollSettings.of(context);
    final resolver = PageVisibilityResolver(metrics: result);
    final index = PageViewSettings.of(context).index;
    final visibility = resolver.resolvePageVisibility(index);

    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateY(pi * visibility.pagePosition),
      child: child,
    );
  }
}
