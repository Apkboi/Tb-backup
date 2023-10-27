import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/generated/l10n.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    super.key,
    required this.name,
    required this.age,
    required this.intent,
    required this.tribe,
    required this.country,
    this.image,
    required this.user,
  });

  final UserDto user;
  final String name;
  final String age;
  final String? image;
  final String intent;
  final String tribe;
  final String country;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          PageUrl.profileDetails,
          queryParameters: {PathParam.userId: user.id.toString()},
        );
      },
      child: Stack(
        children: [
          Container(
            height: 470.h,
          ),
          ImageWidget(
            imageUrl: image ?? '',
            height: .6.sh,
            width: 1.sw,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(15),
          ),
          Positioned.fill(
            bottom: 0,
            // left: 0,
            // right: 0,
            child: Container(
              height: .5.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xffEF0096).withOpacity(.4),
                    Color(0xffEF0096).withOpacity(.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: '$name, $age',
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Pallets.white,
                    ),
                    Row(
                      children: [
                        ImageWidget(
                          imageUrl: Assets.svgsHome,
                          size: 15,
                          color: Pallets.white,
                        ),
                        6.horizontalSpace,
                        TextView(
                          text: country,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Pallets.white,
                        ),
                      ],
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: 'Searching for: $intent',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Pallets.white,
                    ),
                    Row(
                      children: [
                        ImageWidget(
                          imageUrl: Assets.svgsLogoWhite,
                          size: 15,
                          color: Pallets.white,
                        ),
                        6.horizontalSpace,
                        TextView(
                          text: tribe,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Pallets.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
