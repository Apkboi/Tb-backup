import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';

import 'password_reset_controller.dart';

class CompletePasswordResetPage extends ConsumerStatefulWidget {
  const CompletePasswordResetPage({super.key});

  @override
  ConsumerState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends ConsumerState<CompletePasswordResetPage> {
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

    password.dispose();
    confirmPassword.dispose();
  }

  bool passwordsMatch = false;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Password Reset',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: dialogKey,
          onChanged: () {
            setState(() {});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              const TextView(
                text: 'Enter your new password and confirm',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Pallets.grey,
              ),
              32.verticalSpace,
              TextBoxField(
                label: 'Password',
                controller: password,
                isPasswordField: true,
              ),
              TextBoxField(
                label: 'Confirm Password',
                controller: confirmPassword,
                isPasswordField: true,
                hasBottomPadding: false,
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (password.text == confirmPassword.text &&
                      password.text.isNotEmpty)
                    const TextView(
                      text: 'Passwords Match',
                      fontSize: 14,
                      color: Pallets.primaryDark,
                      fontWeight: FontWeight.w500,
                    )
                  else
                    const TextView(
                      text: 'Passwords Do not Match',
                      fontSize: 14,
                      color: Pallets.red,
                      fontWeight: FontWeight.w500,
                    )
                ],
              ),
              56.verticalSpace,
              ButtonWidget(
                title: 'Reset',
                onTap: () {
                  CustomDialogs.showCustomDialog(
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          16.verticalSpace,
                          const Center(
                            child: ImageWidget(
                              imageUrl: Assets.svgsPasswordSuccess,
                            ),
                          ),
                          32.verticalSpace,
                          TextView(
                            text: 'Password change successful',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          8.verticalSpace,
                          TextView(
                            text:
                                'Your password has been changed successfully. Please log in with your new password.',
                          ),
                          32.verticalSpace,
                          ButtonWidget(
                            title: 'Log In',
                            onTap: () {
                              context.goNamed(PageUrl.signIn);
                            },
                          ),
                        ],
                      ),
                    ),
                    context,
                  );
                },
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
