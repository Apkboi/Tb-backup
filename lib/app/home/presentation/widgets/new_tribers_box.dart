import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

class NewTribersBox extends StatelessWidget {
  const NewTribersBox({
    super.key,
    this.name,
    this.image,
    this.distance,
  });

  final String? name;
  final String? image;
  final String? distance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.profileDetails);
      },
      child: Container(
        margin: EdgeInsets.only(right: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: 195,
        decoration: BoxDecoration(
          color: Pallets.primaryLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ImageWidget(imageUrl: Assets.svgsRing),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ImageWidget(
                      imageUrl: image ?? Assets.pngsMale,
                      size: 40,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
            13.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: name ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  7.5.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.svgsRouting),
                      5.horizontalSpace,
                      Expanded(
                        child: TextView(
                          text: "${distance ?? '-'} km away",
                          fontSize: 12,
                          color: Pallets.grey,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
