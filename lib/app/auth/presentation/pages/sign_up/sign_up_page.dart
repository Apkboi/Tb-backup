import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/locale_service/local_notifier.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';
import 'package:triberly/core/utils/localization_extension.dart';
import 'package:triberly/generated/assets.dart';
import 'package:triberly/generated/l10n.dart';

import 'sign_up_controller.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

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

  String completeNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Create an account',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            TextView(
              text: S.of(context).yourPersonalInformation,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            8.verticalSpace,
            TextView(
              text: 'Let’s get to know a bit about you',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            32.verticalSpace,
            TextBoxField(
              label: 'Name',
              controller: firstName,
            ),
            TextBoxField(
              label: 'Surname',
              controller: lastName,
              hasBottomPadding: false,
            ),
            10.verticalSpace,
            TextView(
              text:
                  "Only first name will be displayed. Once this is set, you won't be able to change it",
              fontSize: 12,
            ),
            16.verticalSpace,
            CustomPhoneField(
              controller: phoneNumber,
              initialCountryCode: 'NG',
              onChanged: (number) {
                completeNumber = number.completeNumber;
                // print(number.completeNumber);
              },
            ),
            FilterCustomDropDown(
              hintText: "Gender",
              listItems: ['Male', 'Female'],
              onTap: (value) {},
              hasValidator: true,
            ),
            16.verticalSpace,
            TextBoxField(
              label: 'Email Address',
              controller: email,
            ),
            TextBoxField(
              label: 'Password',
              controller: password,
              isPasswordField: true,
            ),
            TextBoxField(
              label: 'Confirm Password',
              controller: confrimPassword,
              isPasswordField: true,
            ),
            TextBoxField(
              label: 'Referral Code (Optional)',
              controller: referral,
            ),
            38.verticalSpace,
            ButtonWidget(
              title: 'Sign Up',
              onTap: () {
                /// Set user data
                ref
                    .read(signupProvider.notifier)
                    .setUserData(email.text, phoneNumber.text);

                ///

                context.pushNamed(
                  PageUrl.otpPage,
                  queryParameters: {
                    PathParam.phoneNumber: completeNumber,
                  },
                );
                // CustomDialogs.showFlushBar(
                //     context, 'Phone number verified successfully');
              },
            ),
            16.verticalSpace,
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Already have an account?  ',
                    style: ref.read(themeProvider).selectedTextTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              context.pushReplacementNamed(PageUrl.signIn),
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: Pallets.primary,
                        ),
                      ),
                    ]),
              ),
            ),
            32.verticalSpace,
            Row(
              children: [
                Expanded(child: CustomDivider()),
                15.horizontalSpace,
                TextView(
                  text: 'OR',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.primaryDark,
                ),
                15.horizontalSpace,
                Expanded(child: CustomDivider()),
              ],
            ),
            19.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: 'Sign Up with',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Pallets.primaryDark,
                ),
                12.horizontalSpace,
                ImageWidget(imageUrl: Assets.svgsGoogle),
                8.horizontalSpace,
                ImageWidget(imageUrl: Assets.svgsApple),
              ],
            ),
            45.verticalSpace,
          ],
        ),
      ),
    );
  }
}
