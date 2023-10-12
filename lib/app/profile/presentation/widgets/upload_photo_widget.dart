import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';
import 'package:triberly/core/utils/color_utils.dart';

class UploadPhotosWidget extends StatelessWidget {
  const UploadPhotosWidget({
    super.key,
    this.imageUrl,
    this.onTap,
    this.delete,
  });

  final String? imageUrl;

  final VoidCallback? onTap;
  final VoidCallback? delete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imageUrl != null ? null : onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ImageWidget(
            imageUrl: imageUrl ?? Assets.svgsAddPhotos,
            size: 150,
            borderRadius: BorderRadius.circular(10),
            imageType:
                imageUrl != null ? ImageWidgetType.file : ImageWidgetType.asset,
          ),
          Positioned(
            right: -10,
            bottom: 0,
            child: InkWell(
              onTap: delete,
              child: Icon(
                imageUrl == null ? Icons.add_circle_outlined : Icons.cancel,
                size: 30,
                color: Pallets.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
