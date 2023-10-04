import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

import 'package:overlay_support/overlay_support.dart';
import 'package:triberly/generated/assets.dart';

import '../_core.dart';

class CustomDialogs {
  static void showLoading(
    BuildContext context, {
    UniqueKey? key,
    String message = '',
    Color? barrierColor,
  }) async {
    final dialog = Dialog(
      key: key,
      backgroundColor: Colors.transparent,
      elevation: 0,
      // child: PulsatingImage(),

      child: const SpinKitThreeBounce(
        color: Pallets.white,
        size: 50.0,
      ),
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: true,
      barrierColor: barrierColor ?? Pallets.primary.withOpacity(0.3),
      // barrierColor: barrierColor,
    );
  }

  static Future<T?> showBottomSheet<T>(BuildContext context, Widget child,
      {Color? barrierColor}) {
    return showModalBottomSheet<T>(
        backgroundColor: Colors.transparent,
        context: context,
        barrierColor: barrierColor ?? Pallets.primary.withOpacity(0.3),
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: child,
          );
        });
  }

  static void showConfirmDialog(BuildContext context,
      {String message = 'Please confirm if you wish to proceed ?',
      VoidCallback? onYes}) async {
    final dialog = Dialog(
      backgroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        // height: 260,

        width: 200,
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const ImageWidget(
                  imageUrl: Assets.pngsLaunch,
                  size: 50,
                ),
                10.horizontalSpace,
                Expanded(
                  child: TextView(text: message),
                ),
              ],
            ),
            36.verticalSpace,
            // const CustomDivider(),
            // 10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDialog(
                  title: 'Cancel',
                  isInverted: true,
                  onTap: () {
                    hideLoading(context);
                  },
                ),
                ButtonDialog(
                  title: 'Confirm',
                  onTap: onYes,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: true,
    );
  }

  static void showCustomDialog(Widget child, BuildContext context,
      {String title = 'loading...', VoidCallback? onYes}) async {
    final dialog = Dialog(
      backgroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: true,
      barrierColor: Pallets.primary.withOpacity(0.1),
    );
  }

  static void hideLoading(BuildContext context) {
    // if (dialogKey.currentContext != null) {
    // Future.delayed(Duration.zero, () {
    //
    // });

    isThereCurrentDialogShowing(BuildContext context) =>
        ModalRoute.of(context)?.isCurrent != true;

    if (isThereCurrentDialogShowing(context)) {
      context.pop();
    }

    // } else {
    // Future.delayed(const Duration.zero ,() {})
    //     .then((value) => Navigator.of(context).pop());
    // }
  }

  static Widget getLoading({double size = 10.0}) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SpinKitThreeBounce(color: Pallets.primary, size: size),
      );

  static void showSnackBar(
    BuildContext context,
    String message, {
    void Function()? onClose,
    bool error = false,
  }) {
    final snackBar = SnackBar(
      content: TextView(text: message),
      backgroundColor: !error ? Pallets.primary : Colors.red,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'CLOSE',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (onClose != null) {
            onClose();
          }
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// show success notification
  static success(String message) {
    // show a notification at top of screen.
    showSimpleNotification(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Pallets.primaryLight,
          border: Border.all(color: Pallets.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 24.0,
              color: Pallets.primary,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextView(
                text: message.isEmpty ? 'An error occurred' : message,
                fontSize: 14,
                color: Pallets.primary,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
    );
  }

  /// show error notification
  static error(String message) {
    // show a notification at top of screen.

    // show a notification at top of screen.
    showSimpleNotification(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Pallets.white,
          border: Border.all(color: Pallets.red),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.cancel,
              size: 24.0,
              color: Pallets.red,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextView(
                text: message.isEmpty ? 'An error occurred' : message,
                fontSize: 14,
                color: Pallets.red,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
    );
  }

  static void showToast(String message, {bool isError = false}) async {
    await toast.Fluttertoast.showToast(
      msg: message,
      toastLength: toast.Toast.LENGTH_LONG,
      gravity: toast.ToastGravity.BOTTOM,
      backgroundColor: isError ? Pallets.red : Pallets.primary,
      textColor: Pallets.white,
      fontSize: 16,
    );
  }

  static void showFlushBar(BuildContext context, String message,
      {bool isError = false}) async {
    if (isError) {
      showSimpleNotification(
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Pallets.primaryLight,
            border: Border.all(color: Pallets.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 24.0,
                color: Pallets.primary,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextView(
                  text: message.isEmpty ? 'An error occurred' : message,
                  fontSize: 14,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  align: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        background: Colors.transparent,
        elevation: 0,
      );
    } else {
      Flushbar(
        message: message,
        messageColor: Pallets.primary,
        icon: Icon(
          Icons.check_circle,
          size: 24.0,
          color: Pallets.primary,
        ),
        shouldIconPulse: false,
        borderWidth: .5,
        borderColor: Pallets.primary,
        backgroundColor: Pallets.primaryLight,
        margin: EdgeInsets.all(8),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(8),
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}

class ButtonDialog extends StatelessWidget {
  const ButtonDialog({
    super.key,
    this.onTap,
    this.isInverted = false,
    required this.title,
  });

  final VoidCallback? onTap;
  final bool isInverted;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isInverted ? Pallets.borderGrey : Pallets.primary,
        ),
        child: TextView(
          text: title,
          color: isInverted ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class PulsatingImage extends StatefulWidget {
  const PulsatingImage({super.key});

  @override
  _PulsatingImageState createState() => _PulsatingImageState();
}

class _PulsatingImageState extends State<PulsatingImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  var scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      upperBound: 0.8,
      lowerBound: 0.3,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    scaleAnimation = Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,

      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value * 0.4 + 0.2,
          child: child,
        );
      },
      child: Center(
        child: Image.asset(
          Assets.pngsLaunch,
          width: 130,
          height: 130,
        ),
      ), // Replace with your image path
    );
  }
}
