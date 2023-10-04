import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';

import 'otp_controller.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;
  @override
  ConsumerState createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  TextEditingController otpCtrl = TextEditingController();

  final otpLength = 4;
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
        title: 'OTP Verification',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  32.verticalSpace,
                  TextView(
                    text:
                        'Enter the verification code sent to \n${widget.phoneNumber}',
                    align: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    style: ref
                        .watch(themeProvider)
                        .selectedTheme
                        .textTheme
                        .bodyMedium,
                  ),
                  24.verticalSpace,
                  Form(
                    key: dialogKey,
                    onChanged: () {
                      setState(() {});
                    },
                    child: OtpField(
                      count: otpLength,
                      controller: otpCtrl,
                    ),
                  ),
                  24.verticalSpace,
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Haven’t received  an OTP?  ',
                          style: ref
                              .watch(themeProvider)
                              .selectedTextTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Pallets.maybeBlack,
                              ),
                          children: [
                            TextSpan(
                              text: 'Resend',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ///Add resend Function
                                },
                              style: ref
                                  .watch(themeProvider)
                                  .selectedTextTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Pallets.maybeBlack,
                                  ),
                            ),
                          ]),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: 'Request a new code in ',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey,
                      ),
                      CustomCountDown(
                        style: ref
                            .watch(themeProvider)
                            .selectedTextTheme
                            .bodySmall
                            ?.copyWith(
                              color: Pallets.grey,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonWidget(
              title: 'Confirm',
              onTap: otpCtrl.text.length != otpLength
                  ? null
                  : () {
                      context.pushNamed(PageUrl.locationAccessPage);
                      CustomDialogs.success(
                        'Phone number verified successfully',
                      );

                      ///Add confirm Function
                    },
            ),
          ),
          45.verticalSpace,
        ],
      ),
    );
  }
}
