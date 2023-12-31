import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/profile/presentation/widgets/Interests_tab.dart';
import 'package:triberly/app/profile/presentation/widgets/ethnicity_tab.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/app/profile/presentation/widgets/others_tab.dart';
import 'package:triberly/app/profile/presentation/widgets/profile_tab.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';
import 'package:triberly/core/utils/color_utils.dart';

import 'setup_profile_controller.dart';

class SetupProfilePage extends ConsumerStatefulWidget {
  const SetupProfilePage({super.key});

  @override
  ConsumerState createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends ConsumerState<SetupProfilePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  late TabController controller;
  int tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      _handleTabNavigation(tabIndex);
    });
    _getProfile();
  }

  _getProfile() async {
    await Future.delayed(Duration.zero, () async {
      await ref
          .read(setupProfileProvider.notifier)
          .getDataConfigs()
          .then((value) {
        // setState(() {});
      });
    });
  }

  @override
  void dispose() {
    dialogKey.currentState?.dispose();
    super.dispose();
  }

  List<String?> imagesList = [
    null,
    null,
    null,
    null,
  ];

  LinearGradient gradient = LinearGradient(colors: <Color>[
    UtilColor.fromHex('#EF0096').withOpacity(0.5),
    UtilColor.fromHex('#EF0096'),
  ]);
  ValueNotifier<double> sliderValue = ValueNotifier(1);

  void _animateToTargetValue(double targetValue) {
    if (sliderValue.value != targetValue) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
      final animation = Tween<double>(
        begin: sliderValue.value,
        end: targetValue,
      ).animate(controller);
      animation.addListener(() {
        sliderValue.value = animation.value;
      });
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(setupProfileProvider, (previous, next) {
      if (next is SetupProfileLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is SetupProfileError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
        return;
      }

      if (next is SetupProfileSuccess) {
        try {
          CustomDialogs.hideLoading(context);
          CustomDialogs.success(
            'Profile saved successfully',
          );
        } finally {
          _navigateToNextForm();
        }

        return;
      }
    });

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          title: 'Edit profile',
          trailing: Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 20),
              child: ValueListenableBuilder(
                  valueListenable: sliderValue,
                  builder: (context, sliderValue, child) {
                    _profileIsCompleteEnough();
                    return TextView(
                      text: sliderValue == 10 ? 'Done' : '',
                      color: Pallets.maybeBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      onTap: () {
                        context.goNamed(PageUrl.home);
                      },
                    );
                  })),
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: sliderValue,
                builder: (context, sliderListenerValue, child) {
                  return SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 10,
                        inactiveTrackColor: Pallets.primaryLight,
                        thumbShape: SliderComponentShape.noThumb,
                        trackShape: GradientRectSliderTrackShape(
                          gradient: gradient,
                          sliderValue: (sliderListenerValue),
                          darkenInactive: true,
                        ),
                      ),
                      child: Slider(
                        min: 0,
                        max: 10,
                        value: sliderListenerValue,
                        onChanged: (double value) {
                          // setState(() {
                          //   sliderValue.value = value;
                          // });
                        },
                      ));
                }),

            24.verticalSpace,
            SizedBox(
              height: 30,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,

                isScrollable: true,
// tabAlignment: TabAlignment.start,
              indicatorPadding: EdgeInsets.zero,
                controller: controller,
                tabAlignment: TabAlignment.center,

                indicatorColor: Pallets.primary,

                // indicatorPadding: EdgeInsets.symmetric(horizontal: 10),

                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 24),

                unselectedLabelStyle: ref
                    .read(themeProvider.notifier)
                    .selectedTextTheme
                    .titleMedium,

                labelStyle: ref
                    .read(themeProvider.notifier)
                    .selectedTextTheme
                    .titleMedium?.copyWith(fontWeight: FontWeight.w600),
                labelColor: Pallets.black,
                unselectedLabelColor: Pallets.grey,

                // indicator: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8), // Creates border
                //   color: Pallets.primary,
                // ),

                onTap: (currentIndex) {
                  logger.e("CONTROLLER INDEX:${controller.index}");

                  validateFields(controller.previousIndex, currentIndex);
                  logger.e("CURRENT INDEX:$currentIndex");
                  // _handleTabNavigation(currentIndex);
                },

                tabs: const [
                  Tab(
                    height: 20,

                    text: 'Personal bio',
                  ),
                  Tab(text: 'Ethnicity'),
                  Tab(text: 'Interests'),
                  Tab(text: 'Others'),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileTab(controller),
                  EthnicityTab(controller),
                  InterestsTab(controller),
                  OthersTab(controller),
                ],
              ),
            ),
            // ProfileTab(
            //   images: imagesList,
            // ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextForm() {
    if (sliderValue.value == 1) {
      _animateToTargetValue(5);
      controller.index = 1;
      return;
    }
    if (sliderValue.value == 2) {
      _animateToTargetValue(5);
      controller.index = 1;
      return;
    }
    if (sliderValue.value == 5) {
      _animateToTargetValue(7);
      controller.index = 2;

      return;
    }
    _animateToTargetValue(10);
    controller.index = 3;
    return;
  }

  void _handleTabNavigation(int currentIndex) {
    if (currentIndex == 0) {
      _animateToTargetValue(2.toDouble());
      return;
    }
    if (currentIndex == 1) {
      _animateToTargetValue(5.toDouble());
      return;
    }
    if (currentIndex == 2) {
      _animateToTargetValue(7);
      return;
    }
    _animateToTargetValue(10);
    return;
  }

  bool _profileIsCompleteEnough() {
    final userProfile =
        ref.watch(setupProfileProvider.notifier).userProfile.data;

    return userProfile?.tribes != null &&
        userProfile?.originCountryId != null &&
        userProfile?.residenceCountryId != null &&
        userProfile?.interests != null;
  }

  void validateFields(int index, int nextIndex, {bool? skip = false}) {
    switch (index) {
      case 0:
        ref
            .read(setupProfileProvider.notifier)
            .validateProfileForm(ProfileForm.bio, nextIndex);
        break;
      case 1:
        ref
            .read(setupProfileProvider.notifier)
            .validateProfileForm(ProfileForm.ethnicity, nextIndex);
        break;

      case 2:
        ref
            .read(setupProfileProvider.notifier)
            .validateProfileForm(ProfileForm.interest, nextIndex);
        break;
      case 3:
        ref
            .read(setupProfileProvider.notifier)
            .validateProfileForm(ProfileForm.others, nextIndex);
        break;
    }
    tabIndex = controller.index;
  }
}
