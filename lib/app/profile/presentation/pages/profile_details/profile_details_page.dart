import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/presentation/pages/chat/chat_controller.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/core/shared/left_right_widget.dart';

import '../../../../../core/_core.dart';
import 'profile_details_controller.dart';

class ProfileDetailsPage extends ConsumerStatefulWidget {
  const ProfileDetailsPage({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends ConsumerState<ProfileDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  List records = [
    ('Profession', 'Marketing Automation'),
    ('Gender', 'Male'),
    ('Relationship Status', 'Married'),
    ('Looking for', ' Business networking'),
    ('Origin Country', 'Nigeria'),
    ('Other Nationality', 'British'),
    ('Mother Tongue', 'Igbo'),
    (
      'Bio',
      'My name is Bruno Charles and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy travelling as well.'
    ),
    ('Interests', ['Travelling', 'Books']),
    ('Faith', 'Pentecostal'),
    ('Education', 'Masters degree'),
    ('Hashtags', '#Odogwu'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  _getUserData() {
    Future.delayed(Duration.zero, () {
      ref
          .read(profileDetailsProvider.notifier)
          .getUserDetailsMain(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatProvider, (previous, next) {
      if (next is ChatLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is ChatError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
        return;
      }

      if (next is ChatSuccess) {
        context.pop();

        final userDetails =
            ref.watch(profileDetailsProvider.notifier).userDetails;
        final chatId = ref.watch(chatProvider.notifier).initiatedChat?.id;
        context.pushNamed(
          PageUrl.chatDetails,
          queryParameters: {
            PathParam.chatId: "$chatId",
            PathParam.userName:
                "${userDetails?.lastName ?? ''} ${userDetails?.firstName ?? ''}",
          },
        );
        return;
      }
    });
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Builder(builder: (context) {
          if (ref.watch(profileDetailsProvider) is ProfileDetailsLoading) {
            return CustomDialogs.getLoading(size: 50);
          }

          final userDetails =
              ref.watch(profileDetailsProvider.notifier).userDetails;

          final userCountry = ref
                  .read(setupProfileProvider.notifier)
                  .countries
                  .firstWhereOrNull((element) =>
                      element.id == userDetails?.residenceCountryId) ??
              'N/A';

          records = [
            ('Profession', '${userDetails?.profession ?? '-'}'),
            ('Gender', '${userDetails?.gender ?? ''}'),
            (
              'Relationship Status',
              '${userDetails?.relationshipStatus ?? '-'}'
            ),
            ('Looking for', 'N/A'),
            ('Origin Country', userCountry),
            ('Other Nationality', '-'),
            ('Mother Tongue', '${userDetails?.tribes ?? '-'}'),
            ('Bio', '${userDetails?.bio ?? '-'}'),
            ('Interests', ['${userDetails?.interests ?? '-'}']),
            ('Faith', '-'),
            ('Education', '-'),
            ('Hashtags', '-'),
          ];

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      radius: 20,
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Pallets.maybeBlack,
                        opticalSize: 24,
                        size: 24,
                      ),
                    ),
                    InkWell(
                      radius: 20,
                      onTap: () {
                        context.pop();
                      },
                      child: ImageWidget(imageUrl: Assets.svgsMore),
                    ),
                  ],
                ),
                Container(
                  height: 120.w,
                  width: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Pallets.primaryDark,
                      width: 2,
                    ),
                  ),
                  child: ImageWidget(
                    imageUrl: userDetails?.profileImage ?? '',
                    size: 100.w,
                    fit: BoxFit.cover,
                    shape: BoxShape.circle,
                  ),
                ),
                23.verticalSpace,
                TextView(
                  text:
                      "${userDetails?.lastName ?? ''} ${userDetails?.firstName ?? ''}",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                23.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserUpDownWidget(
                      title: 'Tribe',
                      value: '${userDetails?.tribes ?? 'N/A'}',
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      color: Pallets.grey,
                    ),
                    UserUpDownWidget(
                      title: 'Location',
                      value:
                          '${ref.read(setupProfileProvider.notifier).countries.firstWhereOrNull((element) => element.id == userDetails?.residenceCountryId) ?? 'N/A'}',
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      color: Pallets.grey,
                    ),
                    UserUpDownWidget(
                      title: 'Age',
                      value: '${Helpers.calculateAge(userDetails?.dob ?? '')}',
                    ),
                  ],
                ),
                24.verticalSpace,
                CustomDivider(),
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ShadowCircleContainer(
                      child: ImageWidget(
                        imageUrl: Assets.svgsHeart,
                      ),
                    ),
                    ShadowCircleContainer(
                      size: 80,
                      color: Pallets.primary,
                      child: ImageWidget(
                        imageUrl: Assets.svgsLink,
                        color: Pallets.white,
                      ),
                      onTap: () {
                        ref
                            .read(chatProvider.notifier)
                            .initiateChat(widget.userId);
                      },
                    ),
                    ShadowCircleContainer(
                      child: ImageWidget(
                        imageUrl: Assets.svgsBookmark,
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,
                Builder(builder: (context) {
                  if (userDetails?.otherImages?.length == 0) {
                    return SizedBox();
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          TextView(
                            text: 'Photos',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            userDetails?.otherImages?.length ?? 0,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 24.w),
                              child: ImageWidget(
                                imageUrl:
                                    userDetails?.otherImages?[index].url ?? '',
                                size: 134.w,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                24.verticalSpace,
                ...records.map((e) {
                  if (e.$2 is List<String>) {
                    return LeftRightWidget(
                      title: e.$1,
                      value: e.$2.join(', '),
                    );
                  }
                  return LeftRightWidget(
                    title: e.$1,
                    value: e.$2,
                  );
                }).toList(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ShadowCircleContainer extends StatelessWidget {
  const ShadowCircleContainer({
    super.key,
    this.size = 60,
    this.color,
    required this.child,
    this.onTap,
  });

  final double size;
  final Color? color;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.w,
        height: size.w,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color ?? Pallets.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Pallets.primary.withOpacity(0.15),
              blurRadius: 15,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class UserUpDownWidget extends StatelessWidget {
  const UserUpDownWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextView(
          text: title,
          fontSize: 12,
          color: Pallets.grey,
          fontWeight: FontWeight.w400,
        ),
        TextView(
          text: value,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
