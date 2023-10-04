import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';

import 'password_reset_controller.dart';

class PasswordResetPage extends ConsumerStatefulWidget {
  const PasswordResetPage({super.key});

  @override
  ConsumerState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends ConsumerState<PasswordResetPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();

    dataCtrl.dispose();
  }

  TextEditingController dataCtrl = TextEditingController();

  bool isEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Password Reset',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            TextView(
              text: 'Let’s help you get back in',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            16.verticalSpace,
            TextView(
              text:
                  'Enter your email address to begin password reset. An OTP will be sent to your email address.',
              fontSize: 14,
              color: Pallets.grey,
              fontWeight: FontWeight.w500,
            ),
            32.verticalSpace,
            if (isEmail)
              TextBoxField(
                label: 'Email Address',
                controller: dataCtrl,
                hasBottomPadding: false,
              )
            else
              CustomPhoneField(
                controller: dataCtrl,
                initialCountryCode: 'NG',
              ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextView(
                  text: isEmail
                      ? 'Use phone number instead'
                      : 'Use Email instead',
                  fontSize: 14,
                  color: Pallets.primaryDark,
                  fontWeight: FontWeight.w500,
                  onTap: () {
                    setState(() {
                      isEmail = !isEmail;
                    });
                  },
                ),
              ],
            ),
            56.verticalSpace,
            ButtonWidget(
              title: 'Reset',
              onTap: () {
                context.pushNamed(PageUrl.completePasswordReset);
                // CustomDialogs.showFlushBar(
                //     context, 'Phone number verified successfully');
              },
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
