part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.custom();

  @override
  List<AutoRoute> get routes => [
        CustomRoute(page: SplashScreenRoute.page, path: '/'),
        CustomRoute(page: LoginScreenRoute.page, path: '/login'),
        CustomRoute(page: SignUpScreenRoute.page, path: '/signup'),
        CustomRoute(page: ForgetPasswordRoute.page, path: '/forget-password'),
        CustomRoute(page: HomeScreenRoute.page, path: '/home'),
        CustomRoute(page: QRCodeScannerWidgetRoute.page, path: '/qr-home'),
        CustomRoute(page: ErrorRouteScreenRoute.page, path: '/error'),
      ];
}
