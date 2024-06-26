import 'package:app_bluetooth/pages/IntroPage.dart';
import 'package:flutter/material.dart';

import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
    case Routes.IntroPage:
    return MaterialPageRoute(builder: (_) => IntroPage());


      default:
        return MaterialPageRoute(builder: (_) => IntroPage());
    }
  }
}