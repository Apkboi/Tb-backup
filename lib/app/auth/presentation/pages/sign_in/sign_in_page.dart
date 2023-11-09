import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/resend_otp_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_req_dto.dart';
import 'package:triberly/app/auth/presentation/pages/otp/otp_controller.dart';
import 'package:triberly/core/constants/enums/otp_type.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';

import '../../../../../core/_core.dart';
import 'sign_in_controller.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({
    super.key,
    this.email,
  });

  final String? email;

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = widget.email ?? '';

    if (kDebugMode) {
      email.text = 'ma@mailinator.com';
      password.text = 'Password';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
    firstName.dispose();

    lastName.dispose();
    email.dispose();
    gender.dispose();
    password.dispose();
    referral.dispose();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confrimPassword = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(signInProvider, (previous, next) {
      if (next is SignInLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is SignInError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
      }

      if (next is SignInSuccess) {
        CustomDialogs.hideLoading(context);

        final userData = ref.watch(signInProvider.notifier).userData;

        if (userData?.emailVerification == false) {
          ref.read(otpProvider.notifier).resendOtp(
                ResendOtpReqDto(
                  email: userData?.email,
                  type: OtpType.accountSetup.value,
                ),
              );

          context.pushNamed(
            PageUrl.otpPage,
            queryParameters: {
              PathParam.otpType: OtpType.accountSetup.value,
              PathParam.phoneNumber: userData?.phoneNo,
              PathParam.email: userData?.email,
            },
          );
          return;
        }

        if (userData?.profileImage == null) {
          context.pushNamed(PageUrl.uploadProfilePhoto);
          return;
        }
        if (userData?.otherImages == null ||
            (userData?.otherImages?.length == 0)) {
          context.pushNamed(PageUrl.uploadPhotos);
          return;
        }
        if (userData?.dob == null) {
          context.pushNamed(PageUrl.setupProfilePage);
          return;
        }

        context.goNamed(PageUrl.home);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Log in',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: dialogKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              const TextView(
                text: 'Log in to your account',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              32.verticalSpace,
              TextBoxField(
                label: 'Email Address',
                controller: email,
                validator: FieldValidators.emailValidator,
              ),
              TextBoxField(
                label: 'Password',
                controller: password,
                isPasswordField: true,
                hasBottomPadding: false,
                validator: FieldValidators.notEmptyValidator,
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextView(
                    text: 'Forgot Password ?',
                    fontSize: 12,
                    color: Pallets.primaryDark,
                    fontWeight: FontWeight.w500,
                    onTap: () {
                      context.pushNamed(PageUrl.passwordReset);
                    },
                  ),
                ],
              ),
              24.verticalSpace,
              ButtonWidget(
                title: 'Sign In',
                onTap: _signIn,
              ),
              16.verticalSpace,
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "You don't have an account? ",
                      style:
                          ref.read(themeProvider).selectedTextTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                context.pushReplacementNamed(PageUrl.signUp),
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Pallets.primary,
                          ),
                        ),
                      ]),
                ),
              ),
              32.verticalSpace,
              Row(
                children: [
                  const Expanded(child: CustomDivider()),
                  15.horizontalSpace,
                  const TextView(
                    text: 'OR',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Pallets.primaryDark,
                  ),
                  15.horizontalSpace,
                  const Expanded(child: CustomDivider()),
                ],
              ),
              19.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextView(
                    text: 'Sign in with',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Pallets.primaryDark,
                  ),
                  12.horizontalSpace,
                  InkWell(
                    onTap: () {
                      ref.read(signInProvider.notifier).signInGoogle();
                    },
                    child: const ImageWidget(imageUrl: Assets.svgsGoogle),
                  ),
                  16.horizontalSpace,
                  if (Platform.isIOS)
                    InkWell(
                      onTap: () {
                        ref.read(signInProvider.notifier).signInApple();
                      },
                      child: const ImageWidget(imageUrl: Assets.svgsApple),
                    ),
                ],
              ),
              45.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() {
    final data = SignInReqDto(
      email: email.text,
      password: password.text,
    );

    if (dialogKey.currentState!.validate()) {
      ref.read(signInProvider.notifier).signIn(data);
    }
  }
}
