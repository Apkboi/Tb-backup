import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/profile/presentation/widgets/Interests_tab.dart';
import 'package:triberly/app/profile/presentation/widgets/ethnicity_tab.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/app/profile/presentation/widgets/profile_tab.dart';
import 'package:triberly/app/profile/presentation/widgets/upload_photo_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  void animateToTargetValue(double targetValue) {
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        appBar: const CustomAppBar(title: 'Build your profile'),
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
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              // indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 24),
              unselectedLabelStyle: ref
                  .read(themeProvider.notifier)
                  .selectedTextTheme
                  .titleMedium,
              labelStyle: ref
                  .read(themeProvider.notifier)
                  .selectedTextTheme
                  .titleMedium,
              labelColor: Pallets.white,
              unselectedLabelColor: Pallets.grey,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Creates border
                color: Pallets.primary,
              ),
              onTap: (currentIndex) {
                if (currentIndex == 0) {
                  animateToTargetValue(2.toDouble());

                  return;
                }
                if (currentIndex == 1) {
                  animateToTargetValue(5);
                  return;
                }
                if (currentIndex == 2) {
                  animateToTargetValue(7);
                  return;
                }

                animateToTargetValue(10);
                return;
              },
              tabs: [
                Tab(text: 'Personal bio'),
                Tab(text: 'Ethnicity'),
                Tab(text: 'Interests'),
                Tab(text: 'Others'),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  ProfileTab(images: imagesList),
                  EthnicityTab(),
                  InterestsTab(),
                  InterestsTab(),
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
}
