import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/assets/asset_constants.dart';

import '../../../../cache/shared_preferences.dart';
import '../../../cache/prefs_constant.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  static const id = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferences _prefs = Pref.instance.pref;

  Future<String> getAuth() async {
    bool isLoggedIn = _prefs.getBool(PrefConstant.isLoggedIn) ?? false;
    if (isLoggedIn) {
      return '/home';
    }

    await _prefs.remove(PrefConstant.isLoggedIn);
    return '/login';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getAuth(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          Future.delayed(const Duration(seconds: 5),
              () => AutoRouter.of(context).pushNamed(snapshot.data!));
        }
        return Scaffold(
          backgroundColor: const Color(0XFF00bcd4),
          body: Center(
            child: Image.asset(
              AssetConstants.iconAppLogo,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
