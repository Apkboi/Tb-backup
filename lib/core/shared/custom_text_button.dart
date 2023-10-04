import 'package:flutter/material.dart';
import '../../generated/assets.dart';
import '../_core.dart';

class ButtonWidget extends StatefulWidget {
  final bool isDisabled;
  final String title;
  final void Function()? onTap;
  final bool isInverted;
  final bool hasIcon;
  final String? imageLink;
  final bool loading;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final IconData? icon;
  final Widget? widget;

  const ButtonWidget({
    this.onTap,
    this.title = 'Next',
    this.isDisabled = false,
    this.isInverted = false,
    this.hasIcon = false,
    this.loading = false,
    this.imageLink,
    Key? key,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.icon,
    this.widget,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  final bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // height: 48.h,
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 22.h),
          backgroundColor: widget.buttonColor ??
              (widget.isInverted
                  ? Colors.transparent
                  : widget.isDisabled
                      ? Pallets.primary
                      : widget.onTap == null
                          ? Pallets.pinkLight.withOpacity(0.2)
                          : Pallets.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
            side: widget.isInverted
                ? widget.hasIcon
                    ? const BorderSide(color: Pallets.primary, width: 2)
                    : const BorderSide(color: Pallets.primary, width: 1)
                : BorderSide.none,
          ),
        ),
        child: widget.loading
            ? const Center(
                child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ))
            : widget.hasIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon != null
                          ? Icon(
                              widget.icon,
                              color: Pallets.primary,
                            )
                          : Image.asset(
                              widget.imageLink ?? Assets.pngsLaunch,
                              height: 24.h,
                              width: 24.0,
                            ),
                      SizedBox(
                        width: 30.0.w,
                      ),
                      TextView(
                        text: widget.title,
                        fontSize: widget.fontSize ?? 16,
                        fontWeight: FontWeight.w700,
                        color: widget.textColor ??
                            (widget.isInverted
                                ? Pallets.primary
                                : Colors.white),
                      ),
                      SizedBox(
                        width: 30.0.w,
                      ),
                    ],
                  )
                : TextView(
                    text: widget.title,
                    fontSize: widget.fontSize ?? 16,
                    fontWeight: FontWeight.w700,
                    color: widget.textColor ??
                        (widget.isInverted ? Pallets.primary : Colors.white),
                  ),
      ),
    );
  }
}
