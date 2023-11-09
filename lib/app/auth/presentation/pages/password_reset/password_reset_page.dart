import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/forgot_password_req_dto.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/navigation/path_params.dart';

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
    dataCtrl = TextEditingController();
    dataEmailCtrl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // dialogKey.currentState?.dispose();

    dataCtrl.dispose();
    dataEmailCtrl.dispose();
  }

  TextEditingController dataCtrl = TextEditingController();
  TextEditingController dataEmailCtrl = TextEditingController();

  bool isEmail = true;

  @override
  Widget build(BuildContext context) {
    ref.listen(passwordResetProvider, (previous, next) {
      if (next is ForgotPasswordLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is ForgotPasswordError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
      }

      if (next is ForgotPasswordSuccess) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.success(next.message);
        context.pushNamed(
          PageUrl.otpPage,
          queryParameters: {
            PathParam.phoneNumber:
                dataCtrl.text.isNotEmpty ? dataCtrl.text : null,
            PathParam.email:
                dataEmailCtrl.text.isNotEmpty ? dataEmailCtrl.text : null,
          },
        );
      }
    });
    return Scaffold(
      // key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Password Reset',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: dialogKey,
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
                  controller: dataEmailCtrl,
                  hasBottomPadding: false,
                  validator: FieldValidators.emailValidator,
                )
              else
                CustomPhoneField(
                  controller: dataCtrl,
                  initialCountryCode: 'NG',
                ),
              // 10.verticalSpace,
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
                      dataCtrl.clear();
                      dataEmailCtrl.clear();
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
                  final data = ForgotPasswordReqDto(
                    email: dataEmailCtrl.text,
                  );

                  if (dialogKey.currentState!.validate()) {
                    ref
                        .read(passwordResetProvider.notifier)
                        .forgotPasswordinit(data);
                  }
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
