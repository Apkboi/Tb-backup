import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/constants/package_exports.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/shared/text_view.dart';

import '../../../../profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'splash_controller.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  late Animation<double> animation;
  AnimationController? animationCtrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationCtrl = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: animationCtrl!,
        curve: Curves.easeIn,
      ),
    );

    // Future.delayed(Duration.zero, () {
    //
    //   ref.read(setupProfileProvider.notifier).getDataConfigs();
    //   // ref.read(locationProvider.notifier).caller();
    // });

    animationCtrl?.forward();
    animation?.addListener(() async {
      if (animation?.isCompleted ?? false) {

        if (SessionManager.instance.isLoggedIn) {
          // TODO: GET USER PROFILE AND VERIFY
          context.goNamed(PageUrl.home);
        } else {
          context.pushReplacementNamed(PageUrl.onBoardingPage);
        }

      }
    });
  }

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
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffBD0077),
                Color(0xff7C0965),
                Color(0xff470239),
                Color(0xff170112),
              ]),
        ),
        child: Center(
          child: FadeTransition(
            opacity: animation!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(
                  imageUrl: Assets.svgsSplashLogo,
                  size: 72.w,
                  fit: BoxFit.fitWidth,
                ),
                12.verticalSpace,
                TextView(
                  text: 'Connecting Africans in the diaspora',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
