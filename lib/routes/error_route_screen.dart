import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kanlas_assignment/constants/assets/asset_constants.dart';

import '../util/error/error_screen.dart';

@RoutePage()
class ErrorRouteScreen extends StatelessWidget {
  static const String id = "/page-not-found";
  const ErrorRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ErrorScreen(
      image: AssetConstants.imageError404,
      title: "Something went wrong",
      description: "Sorry, Could not find Route",
    );
  }
}
