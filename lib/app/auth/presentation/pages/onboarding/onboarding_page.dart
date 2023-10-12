import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/constants/pallets.dart';

import 'onboarding_controller.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({super.key});

  @override
  ConsumerState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnBoardingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  final PageController pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  int currentIndex = 0;
  final List<String> images = [
    Assets.pngsOnboarding1,
    Assets.pngsOnboarding2,
  ];
  final List<String> texts = [
    'Find people near you and connect as travel buddies, business partners, romantic interests, language swappers or friends.',
    'We speak your language, & chances are, so do millions of others',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: images.length,
            physics: ClampingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: 1.sh,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(images[currentIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ImageWidget(
                      imageUrl: Assets.svgsBlurPink,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: .75.sh,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.0, 0.6, 0.7, 0.72, 0.9],
                          // tileMode: TileMode.decal,
                          colors: [
                            Pallets.white,
                            Pallets.white,
                            Pallets.white.withOpacity(0.5),
                            Pallets.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: kToolbarHeight + 10,
            child: Column(
              children: [
                SizedBox(
                  width: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        width: currentIndex == index ? 10 : 7,
                        height: currentIndex == index ? 10 : 7,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: currentIndex == index
                              ? Pallets.primary
                              : Pallets.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (currentIndex != images.length - 1)
            Positioned(
              right: 25,
              top: kToolbarHeight,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: TextView(
                  text: 'Skip',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallets.white,
                  onTap: () {
                    pageController.animateToPage(images.length - 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                ),
              ),
            ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 45,
            child: (currentIndex == images.length - 1)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextView(
                          text: texts[currentIndex],
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.5,
                        ),
                        56.verticalSpace,
                        ButtonWidget(
                          title: 'Create an Account',
                          onTap: () {
                            context.pushNamed(PageUrl.signUp);
                          },
                        ),
                        24.verticalSpace,
                        ButtonWidget(
                          title: 'Log in ',
                          isInverted: true,
                          onTap: () {
                            context.pushNamed(PageUrl.signIn);
                          },
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextView(
                          text: texts[currentIndex],
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.5,
                        ),
                        56.verticalSpace,
                        ButtonWidget(
                          title: 'Next',
                          onTap: () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linearToEaseOut,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
