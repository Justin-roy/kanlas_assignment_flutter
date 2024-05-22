import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// /// Function to show the loading without context.
// showLoading() {
//   BotToast.showCustomLoading(toastBuilder: (_) {
//     return const CircularProgressIndicator.adaptive();
//   });
// }

/// Function to show the notification without context.
showNotification(
    {required String title, String? subTitle, Duration? duration}) {
  toastification.show(
    title: Text(title),
    autoCloseDuration: duration ?? const Duration(seconds: 5),
  );
}

/// Function to close all loadings.
// closeLoading() {
//   BotToast.closeAllLoading();
// }
