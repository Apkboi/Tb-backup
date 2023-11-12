import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/resend_otp_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/verify_otp_req_dto.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/constants/enums/otp_type.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';

import 'otp_controller.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({
    super.key,
    required this.otpType,
    this.email,
    this.phoneNumber,
  });

  final String? phoneNumber;
  final String? email;
  final String otpType;

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
    ref.listen(otpProvider, (previous, next) {
      if ((next is ResendOtpLoading) || (next is OtpLoading)) {
        CustomDialogs.showLoading(context);
      }

      if (next is ResendOtpError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
        return;
      }

      if (next is ResendOtpSuccess) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.success(next.message ?? 'Successful');
        return;
      }

      if (next is OtpError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
        return;
      }

      if (next is OtpSuccess) {
        CustomDialogs.hideLoading(context);

        CustomDialogs.success(
          'Phone number verified successfully',
        );

        if (widget.otpType == OtpType.accountSetup.value) {
          context.pushNamed(PageUrl.locationAccessPage);
        }

        if (widget.otpType == OtpType.passwordReset.value) {
          context.pushNamed(PageUrl.completePasswordReset);
        }

        return;
      }
    });
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
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
                        'Enter the verification code sent to \n${widget.email ?? widget.phoneNumber}',
                    align: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    // style: ref
                    //     .watch(themeProvider)
                    //     .selectedTheme
                    //     .textTheme
                    //     .bodyMedium,
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
                                fontWeight: FontWeight.w600,
                                color: Pallets.maybeBlack,
                              ),
                          children: [
                            TextSpan(
                              text: 'Resend',
                              recognizer: TapGestureRecognizer()
                                ..onTap = _resendOtp,
                              style: ref
                                  .watch(themeProvider)
                                  .selectedTextTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Pallets.primary,
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
                      const TextView(
                        text: 'Request a new code in ',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Pallets.grey,
                      ),
                      CustomCountDown(
                        style: ref
                            .watch(themeProvider)
                            .selectedTextTheme
                            .bodySmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonWidget(
              title: 'Confirm',
              onTap: otpCtrl.text.length != otpLength ? null : _verifyOtp,
              //
              //   () {
              //
              //
              // _verifyOtp
              //       context.pushNamed(PageUrl.locationAccessPage);
              //       CustomDialogs.success(
              //         'Phone number verified successfully',
              //       );
              //
              //       ///Add confirm Function
              //     },
            ),
          ),
          45.verticalSpace,
        ],
      ),
    );
  }

  void _resendOtp() {

    final data = ResendOtpReqDto(
      email: widget.email,

      type: widget.otpType,
    );

    ref.read(otpProvider.notifier).resendOtp(data);
  }

  void _verifyOtp() {
    final data = VerifyOtpReqDto(
      code: otpCtrl.text,
      type: widget.otpType,
    );

    ref.read(otpProvider.notifier).verifyOtp(data);
  }
}
