import 'package:flutter/material.dart';

import '../_core.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomQrCodeWidget extends StatelessWidget {
  const CustomQrCodeWidget({
    super.key,
    required this.data,
    this.size = 200.0,
  });

  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Pallets.primary,
        ),
        data: data,
        version: QrVersions.auto,
        size: size,
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.circle,
          color: Pallets.primary,
        ),
      ),
    );
  }
}
