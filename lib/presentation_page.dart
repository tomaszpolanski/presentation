import 'package:flutter/material.dart';
import 'package:presentation/page_transformer.dart';
import 'package:presentation/presentation_controller.dart';

class PresentationSettings extends InheritedWidget {
  const PresentationSettings({
    Key key,
    this.controller,
    Widget child,
  }) : super(key: key, child: child);

  final PresentationController controller;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

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
        child: PresentationSettings(
          controller: presentationController,
          child: DefaultTextStyle.merge(
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
        ),
      ),
    );
  }
}

class PresentationPage extends StatelessWidget {
  const PresentationPage({Key key, this.title, this.child}) : super(key: key);

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: DefaultTextStyle(
          style: Theme.of(context).textTheme.display1.copyWith(
              color: const Color(0xFF6AA84F), fontWeight: FontWeight.bold),
          child: title,
        ),
      ),
      body: child,
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
