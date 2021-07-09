import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/widgets/rec_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key key, @required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetPadding: EdgeInsets.all(40),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        width: 250,
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 24.0,
                right: 24.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Error',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 26),
                    ),
                  ),
                  // SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                    child: Text(
                      message,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RectButton(
                      color: AppTheme.colorPrimary,
                      title: 'OK',
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
            Positioned(
              top: -30,
              child: Container(
                width: 65.0,
                height: 65.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 4.0, color: Colors.white),
                  shape: BoxShape.circle,
                  color: AppTheme.colorPrimary,
                ),
                child:
                    // Image(image: AssetImage('assets/icons/donate.png')),
                    Image.asset(
                  'assets/cancel.png',
                  // height: 50.0,
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key key, @required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: EdgeInsets.all(10),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        width: 250,
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 24.0,
                right: 24.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Success',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 26),
                    ),
                  ),
                  // SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                    child: Text(
                      message,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RectButton(
                      color: AppTheme.colorPrimary,
                      title: 'OK',
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
