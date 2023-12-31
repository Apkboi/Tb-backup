import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/auth/presentation/pages/sign_up/sign_up_controller.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/navigation/path_params.dart';

import 'location_access_controller.dart';

class LocationAccessPage extends ConsumerStatefulWidget {
  const LocationAccessPage({super.key});

  @override
  ConsumerState createState() => _LocationAccessPageState();
}

class _LocationAccessPageState extends ConsumerState<LocationAccessPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

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
      appBar: CustomAppBar(
        title: 'Location Access',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'We need access to your location',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                8.verticalSpace,
                TextView(
                  text:
                      'Your location helps us to connect you with other trybers close to you and other services',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Center(child: ImageWidget(imageUrl: Assets.svgsLocationAccess)),
            Padding(
              padding: const EdgeInsets.only(bottom: 55.0),
              child: ButtonWidget(
                title: 'Grant location access',
                onTap: () async {
                  final userEmail =
                      ref.read(signupProvider.notifier).getUserData.$1;

                  CustomDialogs.showLoading(context);

                  await ref
                      .read(locationAccessProvider.notifier)
                      .getUserLocation()
                      .then((value1) async {
                    final data = UpdateProfileReqDto(
                      latitude: value1?.latitude,
                      longitude: value1?.longitude,
                    );
                    await ref
                        .read(setupProfileProvider.notifier)
                        .updateProfile(data)
                        .then((value) {
                      CustomDialogs.hideLoading(context);

                      CustomDialogs.showToast('Please login to continue');

                      /// Pushing New Page
                      context.goNamed(PageUrl.signIn, queryParameters: {
                        PathParam.email: userEmail,
                      });
                    });

                    ///
                  }, onError: (e) {});
                },
              ),
            ),
            // 55.verticalSpace,
          ],
        ),
      ),
    );
  }
}
