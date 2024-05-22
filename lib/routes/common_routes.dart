import 'package:flutter/material.dart';
import 'package:kanlas_assignment/features/auth/forget_password.dart';
import 'package:kanlas_assignment/features/home/home.dart';
import 'package:kanlas_assignment/features/splash/splash_screen.dart';
import 'package:kanlas_assignment/widgets/scanner/qr_scanner.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/sign_up_screen.dart';
import 'base_route_helper.dart';
import 'error_route_screen.dart';

class CommonRoutes extends BaseRouteHelper {
  @override
  Route<dynamic>? generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case LoginScreen.id:
          return MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          );
        case SignUpScreen.id:
          return MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          );
        case HomeScreen.id:
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        case QRCodeScannerWidget.id:
          return MaterialPageRoute(
            builder: (context) => const QRCodeScannerWidget(),
          );
        case ForgetPassword.id:
          return MaterialPageRoute(
            builder: (context) => const ForgetPassword(),
          );
        case SplashScreen.id:
          return MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          );
        default:
          return MaterialPageRoute(
            builder: (context) {
              return const ErrorRouteScreen();
            },
          );
      }
    } catch (e) {
      debugPrint(e.toString());
      return MaterialPageRoute(
        builder: (context) {
          return const ErrorRouteScreen();
        },
      );
    }
  }
}
