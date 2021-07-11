import 'dart:async';
import 'package:flutter/widgets.dart';

final GlobalCache cache = GlobalCache();

class GlobalCache {
  String userEmail;
}

final StreamController<bool> openOrderTabController =
    StreamController<bool>.broadcast();
