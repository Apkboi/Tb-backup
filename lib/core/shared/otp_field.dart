import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:triberly/core/_core.dart';

import '../constants/pallets.dart';

class OtpField extends StatelessWidget {
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;
  final bool useNativeKeyboard;
  final bool obscureText;
  final int count;
  final TextEditingController? controller;

  OtpField({
    Key? key,
    this.onCompleted,
    this.validator,
    this.count = 4,
    this.obscureText = false,
    this.useNativeKeyboard = true,
    this.controller,
  }) : super(key: key);

  final defaultPinTheme = PinTheme(
    width: 60.w,
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 5.w),
    textStyle: TextStyle(
      fontSize: 24.sp,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    decoration: BoxDecoration(
      color: Pallets.black,
      border: Border.all(color: Pallets.unselectedGrey, width: 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Pallets.unselectedGrey, width: 1),

        // border: Border.symmetric(
        //     vertical: BorderSide.none, horizontal: BorderSide.none),
      ),
    );

    final submittedPinTheme = focusedPinTheme;

    return Pinput(
      obscureText: obscureText,
      length: count,
      obscuringWidget: const Text(
        '⬤',
        style: TextStyle(fontSize: 12),
      ),
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      controller: controller,
      useNativeKeyboard: useNativeKeyboard,

      ///For autofill on otp received
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,

      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: validator,

      //     (s) {
      //   ///TODO(TAMUNOR): check for the response from api and display the error with this
      //   // return s == '2222' ? null : 'Pin is incorrect';
      // },
      onCompleted: onCompleted,
    );
  }
}
