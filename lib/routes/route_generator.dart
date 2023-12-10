import 'package:flutter/material.dart';

import '../pages/login_screen.dart';
import '../pages/registration_screen.dart';
import '../pages/splash_screen.dart';


class RouteGenerator{
  static Route<dynamic>? generateRoute(RouteSettings settings){
    final arg = settings.arguments;

    switch (settings.name) {

      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RegistrationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());

      default:
        _onPageNotFound();

    }
  }

  static Route<dynamic> _onPageNotFound() {
    return MaterialPageRoute(builder: (_) => const Scaffold(body: Text("Page Not Found")),
    );
  }


}