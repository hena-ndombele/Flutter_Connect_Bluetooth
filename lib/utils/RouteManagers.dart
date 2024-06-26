import 'package:app_bluetooth/pages/IntroPage.dart';
import 'package:flutter/material.dart';

import '../pages/AppareilPage.dart';
import 'Routes.dart';

class RoutesManager {
  static Route route(RouteSettings r) {
    switch (r.name) {
    case Routes.IntroPage:
    return MaterialPageRoute(builder: (_) => IntroPage());
      case Routes.AppareilPage:
        return MaterialPageRoute(builder: (_) => ListeAppareilPage());
        default:
        return MaterialPageRoute(builder: (_) => IntroPage());
    }
  }
}