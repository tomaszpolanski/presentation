import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

void main() {
  runApp(const PresentationExample());
}

class PresentationExample extends StatefulWidget {
  const PresentationExample({Key? key}) : super(key: key);
  @override
  _PresentationExampleState createState() => _PresentationExampleState();
}

class _PresentationExampleState extends State<PresentationExample> {
  late PageController _controller;
  late PresentationController _presentationController;

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
    return MaterialApp(
      home: Presentation(
        controller: _controller,
        presentationController: _presentationController,
        children: const [
          SimplePage('1'),
          SimplePage('2'),
        ],
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  const SimplePage(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
