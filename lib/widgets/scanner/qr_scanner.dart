import 'package:flutter/material.dart';
import 'package:kanlas_assignment/constants/assets/asset_constants.dart';
import 'package:kanlas_assignment/util/bot_toast/bot_toast_functions.dart';
import 'package:kanlas_assignment/widgets/buttons/small_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerWidget extends StatefulWidget {
  const QRCodeScannerWidget({super.key});
  static const id = '/scanner';

  @override
  State<QRCodeScannerWidget> createState() => _QRCodeScannerWidgetState();
}

class _QRCodeScannerWidgetState extends State<QRCodeScannerWidget> {
  bool isScanning = false;
  String? qrCode;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.width * 0.2),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: size.width * 0.2),
          Center(
            child: SizedBox(
              width: size.width * 0.9,
              height: size.width * 0.9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.68,
                    height: size.width * 0.68,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: MobileScanner(
                        allowDuplicates: false,
                        controller: MobileScannerController(
                          facing: CameraFacing.back,
                          torchEnabled: false,
                        ),
                        onDetect: (barcode, args) async {
                          if (barcode.rawValue == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            final String code = barcode.rawValue!;
                            qrCode = code;
                            setState(() => isScanning = true);
                            debugPrint('Barcode found! $code');
                          }
                        },
                      ),
                    ),
                  ),
                  Image.asset(
                    AssetConstants.scanning,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: size.width * 0.6,
            height: size.width * 0.1,
            child: SmallButton(
              isDisabled: !isScanning,
              radius: 12,
              fontSize: 14,
              label: "Scan",
              onPressed: isScanning
                  ? () {
                      if (qrCode != null) {
                        Navigator.pop(context, qrCode);
                      } else {
                        showNotification(title: "something-went-wrong");
                      }
                    }
                  : null,
            ),
          ),
          SizedBox(height: size.width * 0.2),
        ],
      ),
    );
  }
}
