import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({
    Key key,
    @required this.title,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MediaQuery(
          data: const MediaQueryData(padding: EdgeInsets.only(top: 20)),
          child: Scaffold(
            appBar: AppBar(
              primary: true,
              title: title,
            ),
            body: Align(child: child),
          ),
        ),
        Container(
          height: 28,
          color: Colors.black.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.signal_cellular_4_bar,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.battery_charging_full,
                color: Colors.white,
                size: 18,
              ),
              Text(
                DateFormat.Hm().format(DateTime.now()),
                style: Theme.of(context).textTheme.body2.copyWith(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
