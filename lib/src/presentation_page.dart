import 'package:flutter/material.dart';

class PresentationPage extends StatelessWidget {
  const PresentationPage({
    super.key,
    required this.title,
    this.child,
  });

  final Widget title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: const Color(0xFF6AA84F),
                fontWeight: FontWeight.bold,
              ),
          child: title,
        ),
      ),
      body: child,
    );
  }
}
