import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kanlas_assignment/routes/routes_import.gr.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';

@RoutePage()
class QRCodeScannerWidget extends StatelessWidget {
  const QRCodeScannerWidget({super.key});
  static const id = '/scanner';

  @override
  Widget build(BuildContext context) {
    return QRCodeReaderSquareWidget(
      onDetect: (QRCodeCapture capture) {
        var code = capture.raw;
        // Navigator.pop(context, code);
        AutoRouter.of(context)
            .popAndPush(const HomeScreenRoute(), result: code);
      },
      size: 250,
    );
  }
}
