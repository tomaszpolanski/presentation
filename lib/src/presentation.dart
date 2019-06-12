import 'package:flutter_web/material.dart';
import 'package:presentation/src/page_transformer.dart';
import 'package:presentation/src/presentation_controller.dart';

class Presentation extends StatelessWidget {
  const Presentation({
    Key key,
    @required this.children,
    @required this.controller,
    @required this.presentationController,
  }) : super(key: key);

  final List<Widget> children;
  final PageController controller;
  final PresentationController presentationController;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
        ];
      },
      body: GestureDetector(
        key: Key('presentation'),
        onTap: presentationController.nextStep,
        onDoubleTap: presentationController.previousStep,
        child: ScrollNotifier(
          child: PageView.builder(
            controller: controller,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return PageViewSettings(
                index: index,
                child: children[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PageViewSettings extends InheritedWidget {
  const PageViewSettings({
    Key key,
    @required this.index,
    @required Widget child,
  }) : super(key: key, child: child);

  final int index;

  static PageViewSettings of(BuildContext context) {
    final PageViewSettings widget =
        context.inheritFromWidgetOfExactType(PageViewSettings);
    return widget;
  }

  @override
  bool updateShouldNotify(PageViewSettings oldWidget) =>
      index != oldWidget.index;
}

// class PresentationSettings extends InheritedWidget {
//   const PresentationSettings({
//     Key key,
//     this.controller,
//     Widget child,
//   }) : super(key: key, child: child);

//   final PresentationController controller;

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) => false;
// }

/// Based on https://github.com/roughike/page-transformer
/// A class that can be used to compute visibility information about
/// the current page.
class PageVisibilityResolver {
  const PageVisibilityResolver({
    ScrollMetrics metrics,
    double viewPortFraction,
  })  : _pageMetrics = metrics,
        _viewPortFraction = viewPortFraction;

  final ScrollMetrics _pageMetrics;
  final double _viewPortFraction;

  /// Calculates visibility information for the page at [pageIndex].
  /// Used inside PageViews' itemBuilder, but can be also used in a
  /// simple PageView that simply has an array of children passed to it.
  PageVisibility resolvePageVisibility(int pageIndex) {
    final double pagePosition = _calculatePagePosition(pageIndex);
    final double visiblePageFraction =
        _calculateVisiblePageFraction(pageIndex, pagePosition);

    return PageVisibility(
      visibleFraction: visiblePageFraction,
      pagePosition: pagePosition,
    );
  }

  double _calculateVisiblePageFraction(int index, double pagePosition) =>
      pagePosition > -1.0 && pagePosition <= 1.0
          ? 1.0 - pagePosition.abs()
          : 0.0;

  double _calculatePagePosition(int index) {
    final double viewPortFraction = _viewPortFraction ?? 1.0;
    final double pageViewWidth =
        (_pageMetrics?.viewportDimension ?? 1.0) * viewPortFraction;
    final double pageX = pageViewWidth * index;
    final double scrollX = _pageMetrics?.pixels ?? 0.0;
    final double pagePosition = (pageX - scrollX) / pageViewWidth;
    final double safePagePosition = !pagePosition.isNaN ? pagePosition : 0.0;

    if (safePagePosition > 1.0) {
      return 1;
    } else if (safePagePosition < -1.0) {
      return -1;
    }

    return safePagePosition;
  }
}

/// A class that contains visibility information about the current page.
class PageVisibility {
  const PageVisibility({
    @required this.visibleFraction,
    @required this.pagePosition,
  });

  /// How much of the page is currently visible, between 0.0 and 1.0.
  ///
  /// For example, if only the half of the page is visible, the
  /// value of this is going to be 0.5.
  ///
  /// This doesn't contain information about where the page is
  /// disappearing to or appearing from. For that, see [pagePosition].
  final double visibleFraction;

  /// Tells the position of this page, relative to being visible in
  /// a "non-dragging" position, between -1.0 and 1.0.
  ///
  /// For example, if the page is fully visible, this value equals 0.0.
  ///
  /// If the page is fully out of view on the right, this value is
  /// going to be 1.0.
  ///
  /// Likewise, if the page is fully out of view, on the left, this
  /// value is going to be -1.0.
  final double pagePosition;
}
