import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/utils/color_utils.dart';

import '../../../../auth/presentation/widgets/onboarding/intro_dialog.dart';

class SetupProfileIntroPage extends ConsumerStatefulWidget {
  const SetupProfileIntroPage({super.key});

  @override
  ConsumerState createState() => _SetupProfileIntroState();
}

class _SetupProfileIntroState extends ConsumerState<SetupProfileIntroPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  ConfettiController? _controllerCenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _showDialogIfNeeded();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter?.play();
  }

  @override
  void dispose() {
    _controllerCenter?.dispose();

    dialogKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFF00A0),
              Color(0xffB9007F),
              Color(0xffA70077),
              Color(0xff800066),
              UtilColor.fromHex('#22001B'),
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ImageWidget(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/triberly-app.appspot.com/o/app_images%2Fprofile_welcome.png?alt=media&token=4618edb5-f444-45b3-b9f4-19096cd293d3&_gl=1*1pvi5q*_ga*MTcyOTUxNDYxLjE2OTA4NjU0MzM.*_ga_CW55HF8NVT*MTY5NjYyNjU0NC4yOC4xLjE2OTY2MjcwMzUuNDUuMC4w',
                  width: double.infinity,
                  height: 1.sh,
                ),
              ],
            ),
            Positioned(
              bottom: -45,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: true,
                child: Container(
                  height: 0.5.sh,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(
                        imageUrl: Assets.svgsConfetti,
                        size: 60,
                      ),
                      ConfettiWidget(
                        numberOfParticles: 10,
                        confettiController:
                            _controllerCenter ?? ConfettiController(),
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                      ),
                      16.verticalSpace,
                      const TextView(
                        text: 'Welcome to Triberly!',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      16.verticalSpace,
                      const TextView(
                        text:
                            "We're excited to welcome you to Triberly. You will need to complete your profile so you can be visible to others and start making connections.",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center,
                        color: Pallets.grey,
                      ),
                      34.verticalSpace,
                      ButtonWidget(
                        title: 'Complete profile',
                        onTap: () {
                          context.pushNamed(PageUrl.uploadPhotos);
                        },
                      ),
                      16.verticalSpace,
                      TextView(
                        text: 'Skip and complete later',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center,
                        color: Pallets.grey,
                        onTap: () {
                          ref.read(isFirsTImeProvider.notifier).state = true;
                          context.goNamed(PageUrl.home);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _showDialogIfNeeded() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return  Center(
  //         child: Column(
  //           children: [
  //             ImageWidget(imageUrl: Assets.);
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
