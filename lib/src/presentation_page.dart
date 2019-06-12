import 'package:flutter_web/material.dart';

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
