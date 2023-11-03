import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/pages/location/location_controller.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/generated/l10n.dart';

class NewTribersBox extends StatelessWidget {
  const NewTribersBox({
    super.key,
    this.name,
    this.id,
    this.image,
    this.distance,
    this.userDto,
  });

  final String? name;
  final String? id;
  final String? image;
  final String? distance;
  final UserDto? userDto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          PageUrl.profileDetails,
          queryParameters: {PathParam.userId: id},
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 24.w),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: 195,
        decoration: BoxDecoration(
          color: Pallets.primaryLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                const ImageWidget(imageUrl: Assets.svgsRing),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ImageWidget(
                      imageUrl: image ?? '',
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
                      const ImageWidget(imageUrl: Assets.svgsRouting),
                      5.horizontalSpace,
                      Consumer(
                        builder: (context, ref, child) {
                          final location =
                              ref.watch(locationProvider.notifier).userLocation;

                          logger
                              .e("${userDto?.longitude},${userDto?.latitude}");
                          logger.e(
                              "${location?.longitude},${location?.latitude}");

                          return Expanded(
                            child: TextView(
                              text:
                                  "${Helpers.calculateDistance(userDto?.latitude, userDto?.longitude, location?.latitude, location?.longitude) ?? '-'} km away",
                              fontSize: 12,
                              color: Pallets.grey,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
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
