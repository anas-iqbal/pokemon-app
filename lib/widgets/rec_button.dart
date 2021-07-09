import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/app_theme.dart';

class RectButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color color;

  const RectButton({Key key, this.title, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.0,
      child: RaisedButton(
        color: color ?? AppTheme.colorPrimary,
        child: Text(
          title,
          style: TextStyle(color: AppTheme.colorButtonText),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
