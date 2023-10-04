import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/shared/left_right_widget.dart';

import '../../../../../core/_core.dart';
import 'profile_details_controller.dart';

class ProfileDetailsPage extends ConsumerStatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  ConsumerState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends ConsumerState<ProfileDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  final List records = [
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  imageUrl: Assets.pngsMale,
                  size: 100.w,
                  fit: BoxFit.cover,
                  shape: BoxShape.circle,
                ),
              ),
              23.verticalSpace,
              TextView(
                text: 'Bruno Njuagu',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              23.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserUpDownWidget(
                    title: 'Tribe',
                    value: 'Igbo',
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    color: Pallets.grey,
                  ),
                  UserUpDownWidget(
                    title: 'Location',
                    value: 'London',
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    color: Pallets.grey,
                  ),
                  UserUpDownWidget(
                    title: 'Age',
                    value: '32',
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
                  ),
                  ShadowCircleContainer(
                    child: ImageWidget(
                      imageUrl: Assets.svgsBookmark,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
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
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: ImageWidget(
                        imageUrl: Assets.pngsMale,
                        size: 134.w,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
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
        ),
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
  });

  final double size;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
