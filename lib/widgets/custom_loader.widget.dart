import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/app_theme.dart';

class LoaderWidget extends StatefulWidget {
  final bool isTrue;
  final Widget child;
  LoaderWidget({Key key, @required this.isTrue, @required this.child})
      : super(key: key);

  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    offset = Tween<Offset>(begin: Offset(0.0, -1.2), end: Offset(0.0, 4.0))
        .animate(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTrue) {
      controller.forward();
    } else {
      controller.reverse();
    }
    // RefreshIndicatorState()

    return AbsorbPointer(
      absorbing: widget.isTrue,
      child: Stack(
        children: <Widget>[
          Container(child: widget.child),
          Align(
            alignment: Alignment(0.0, -1.2),
            child: SlideTransition(
              position: offset,
              child: RefreshProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.colorPrimary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
