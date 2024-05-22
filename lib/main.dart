import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/cache/shared_preferences.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_bloc.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';
import 'package:toastification/toastification.dart';

import 'package:url_strategy/url_strategy.dart';
import 'routes/routes_import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.instance.init();

  // this plugin method remove hashtag from url --[setPathUrlStrategy]--
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Assignment',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Pallet.purple),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0XFFA7D8CF),
          ),
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
