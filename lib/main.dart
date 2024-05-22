import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/cache/shared_preferences.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_bloc.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';

import 'features/splash/splash_screen.dart';
import 'routes/error_route_screen.dart';
import 'routes/route_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routeHelper = RouteHelper();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: BotToastInit(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Pallet.purple),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0XFFA7D8CF),
        ),
        onGenerateRoute: _routeHelper.getRoutes,
        initialRoute: SplashScreen.id,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const ErrorRouteScreen(),
        ),
      ),
    );
  }
}
