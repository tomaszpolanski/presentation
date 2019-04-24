import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation_controller.dart';
import 'package:presentation/presentation_page.dart';

void main() {
  // Enables rendering on desktop
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(PresentationExample());
}

class PresentationExample extends StatefulWidget {
  @override
  _PresentationExampleState createState() => _PresentationExampleState();
}

class _PresentationExampleState extends State<PresentationExample> {
  PageController _controller;
  PresentationController _presentationController;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _presentationController = PresentationController(controller: _controller);
  }

  @override
  void dispose() {
    _presentationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Presentation(
      controller: _controller,
      presentationController: _presentationController,
      children: const [
        SimplePage('1'),
      ],
    );
  }
}

class SimplePage extends StatelessWidget {
  const SimplePage(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
