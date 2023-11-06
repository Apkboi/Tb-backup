import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triberly/app/auth/domain/models/onboarding_data.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/constants/pallets.dart';

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
          Container(
            height: double.infinity,
            width: 1.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffBD0077),
                    Color(0xff7C0965),
                    Color(0xff470239),
                    Color(0xff170112),
                  ]),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(
                imageUrl: Assets.pngsOnboardingBg,
                height: 0.45.sh,
                // fit: BoxFit.fitHeight,
                width: double.infinity,
              ),
              50.verticalSpace,
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: OnboardingData.data.length,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextView(
                            text: OnboardingData.data[currentIndex].title,
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Pallets.onboardingTextWhite,
                          ),
                          16.verticalSpace,
                          TextView(
                            text: OnboardingData.data[currentIndex].description,
                            fontSize: 16,
                            lineHeight: 1.7,
                            color: Pallets.onboardingTextWhite,
                          ),


                        ],
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          OnboardingData.data.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: currentIndex == index ? 10 : 7,
                            height: currentIndex == index ? 10 : 7,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              color: currentIndex == index
                                  ? Pallets.white
                                  : Pallets.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.bottomCenter,
                child:   (currentIndex == images.length)
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    35.verticalSpace,
                    ButtonWidget(
                      title: 'Create an Account',
                      buttonColor: Pallets.white,
                      textColor: Pallets.primary,
                      onTap: () {
                        context.pushNamed(PageUrl.signUp);
                      },
                    ),
                    16.verticalSpace,
                    InkWell(
                      onTap: (){
                        context.pushNamed(PageUrl.signIn);

                      },
                      child: RichText(text:  TextSpan(style:  GoogleFonts.plusJakartaSans(),children: const [
                        TextSpan(text: "Already have account?",style: TextStyle(fontWeight: FontWeight.w400)),
                        TextSpan(text: "Login",style: TextStyle(fontWeight: FontWeight.w700)),
                      ])),
                    )
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    35.verticalSpace,
                    ButtonWidget(
                      title: 'Next',
                      buttonColor: Pallets.white,
                      textColor: Pallets.primary,
                      onTap: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linearToEaseOut,
                        );
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),),

              45.verticalSpace,
            ],
          ),
          if (currentIndex != images.length)
            Positioned(
              right: 25,
              top: kToolbarHeight,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Pallets.white,foregroundColor: Pallets.primary,shape: StadiumBorder()),
                  onPressed: () {
                    pageController.animateToPage(images.length - 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  },
                  child: const TextView(
                    text: 'Skip',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,



                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
