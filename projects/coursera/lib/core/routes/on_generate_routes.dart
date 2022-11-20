import '../../views/authentication/sign_in/sign_in_with_organization/sign_in_with_organization.view.dart';
import '../../views/authentication/sign_in/sign_in_with_email/sign_in_with_email_view.dart';
import '../../views/authentication/sign_up/sign_up_view.dart';
import '../../views/home_view.dart';
import '../../views/splash_view.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static String homeRoutes = "/";

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/unknown":
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Text('This route unknown for ${settings.name}'),
        );
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _buildMaterialPageRoute(const SplashView());

      case "/SignInView":
        return _buildMaterialPageRoute(const SignInView());

      case "/SignInWithEmail":
        return _buildMaterialPageRoute(const SignInWithEmailView());

      case "/SignUpView":
        return _buildMaterialPageRoute(const SignUpView());

      case "/HomeView":
        return _buildMaterialPageRoute(const HomeView());

      default:
        return _buildMaterialPageRoute(
          Text('No route defined for ${settings.name}'),
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildMaterialPageRoute(Widget screen) {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
    );
  }
}
