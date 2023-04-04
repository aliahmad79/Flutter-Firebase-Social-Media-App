import 'package:flutter/material.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/view/forgot_password/forgot_password.dart';
import 'package:social_media_app/view/login/login_screen.dart';
import 'package:social_media_app/view/signup/sign_up_screen.dart';

import '../../view/Dashboard/dashboard.dart';
import '../../view/splash/splash_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}