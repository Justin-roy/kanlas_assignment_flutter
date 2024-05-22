import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context, {
  Duration duration = const Duration(milliseconds: 4000),
  bool isWrongMessage = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      duration: duration,
      margin: const EdgeInsets.all(8.0),
      behavior: SnackBarBehavior.floating,
      elevation: 0.0,
      content: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: MediaQuery.sizeOf(context).width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: isWrongMessage
                ? [
                    const Color(0xFF7E0303),
                    const Color(0xFFEA452B),
                  ]
                : [
                    const Color(0xFF33BB72),
                    const Color(0xFF2BA289),
                  ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListTile(
          leading: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isWrongMessage ? Colors.red : const Color(0XFF24834F),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              isWrongMessage ? Icons.close : Icons.check,
              size: 15,
              color: Colors.white,
            ),
          ),
          title: Text(
            isWrongMessage ? "Points Not Added" : "Points Added",
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            isWrongMessage
                ? "Your scan was not successfully keep scanning to earn more money."
                : "Your scan was successfully keep scanning to earn more money.",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
