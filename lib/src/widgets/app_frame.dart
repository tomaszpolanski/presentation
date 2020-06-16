import 'package:flutter/material.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({
    Key key,
    @required this.title,
    this.time,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget title;
  final Widget time;
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
              const Icon(
                Icons.signal_cellular_4_bar,
                color: Colors.white,
                size: 18,
              ),
              const Icon(
                Icons.battery_charging_full,
                color: Colors.white,
                size: 18,
              ),
              DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                child: time ??
                    Builder(
                      builder: (context) {
                        final now = DateTime.now();
                        return Text(
                            '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}');
                      },
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _twoDigits(int n) => n >= 10 ? '$n' : '0$n';
