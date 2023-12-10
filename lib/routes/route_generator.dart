import 'package:flutter/material.dart';

import '../pages/splash_screen.dart';


class RouteGenerator{
  static Route<dynamic>? generateRoute(RouteSettings settings){
    final arg = settings.arguments;

    switch (settings.name) {

      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());


      default:
        _onPageNotFound();

    }
  }

  static Route<dynamic> _onPageNotFound() {
    return MaterialPageRoute(builder: (_) => const Scaffold(body: Text("Page Not Found")),
    );
  }


}