import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/page_transformer.dart';
import 'package:presentation/src/presentation.dart';

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key? key,
    this.translationFactor = 100.0,
    required this.child,
  }) : super(key: key);

  final double translationFactor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final result = ScrollSettings.of(context);
    final resolver = PageVisibilityResolver(metrics: result);
    final index = PageViewSettings.of(context)!.index;
    final visibility = resolver.resolvePageVisibility(index);
    final double xTranslation = visibility.pagePosition * 100;
    return Opacity(
      opacity: visibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(xTranslation, 0, 0),
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('translationFactor', translationFactor));
  }
}

class ParallaxImage extends StatelessWidget {
  const ParallaxImage(
    this.asset, {
    Key? key,
  }) : super(key: key);

  final String asset;

  @override
  Widget build(BuildContext context) {
    final result = ScrollSettings.of(context);
    final resolver = PageVisibilityResolver(metrics: result);
    final index = PageViewSettings.of(context)!.index;
    final visibility = resolver.resolvePageVisibility(index);
    return Image.asset(
      asset,
      fit: BoxFit.fitHeight,
      alignment: Alignment(visibility.pagePosition, 0),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('asset', asset, showName: false));
  }
}
