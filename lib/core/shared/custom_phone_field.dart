import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../_core.dart';

class CustomPhoneField extends StatefulWidget {
  const CustomPhoneField(
      {Key? key,
      this.onChanged,
      required this.controller,
      this.validator,
      this.enabled = true,
      this.topLabel = false,
      this.initialCountryCode})
      : super(key: key);

  final Function(PhoneNumber)? onChanged;
  final TextEditingController controller;
  final String? initialCountryCode;
  final bool enabled;
  final bool topLabel;
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          if (widget.topLabel)
            return Column(
              children: [
                TextView(
                  text: 'Phone Number',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.maybeBlack,
                ),
                8.verticalSpace,
              ],
            );
          return SizedBox();
        }),
        IntlPhoneField(
          // showDropdownIcon: false,

          enabled: widget.enabled,
          controller: widget.controller,
          validator: widget.validator,
          pickerDialogStyle: PickerDialogStyle(padding: EdgeInsets.zero),
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          dropdownIcon: const Icon(
            Icons.keyboard_arrow_down,
            size: 7,
            color: Colors.transparent,
          ),
          decoration: InputDecoration(
            labelText: 'Phone Number',
            filled: true,

            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            //
            // suffix: widget.enabled
            //     ? null
            //     : const ImageWidget(
            //         imageUrl: Assets.svgsPadlock,
            //         size: 16,
            //       ),

            errorMaxLines: 1,

            labelStyle: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Pallets.grey,
            ),
            hintText: "Enter Phone Number",
            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Pallets.grey,
            ),

            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            // errorStyle: TextStyle(fontSize: 10),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Pallets.primary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Pallets.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),

            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.controller.text.isEmpty
                    ? Pallets.borderGrey
                    : Pallets.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.controller.text.isEmpty
                    ? Pallets.borderGrey
                    : Pallets.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            // disabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide.none,
            // ),
          ),

          initialCountryCode: widget.initialCountryCode,
          onChanged: widget.onChanged,
        ),
        5.verticalSpace,
      ],
    );
  }
}
