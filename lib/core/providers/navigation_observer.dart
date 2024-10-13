import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      if (kDebugMode) {
        print('Page pushed from: ${previousRoute.settings.name}');
      }
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      if (kDebugMode) {
        print('Page popped to: ${previousRoute.settings.name}');
      }
    }
  }
}
