import 'dart:io';
import 'dart:ui';

import 'package:dart_ipify/dart_ipify.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as launch;
import 'package:uuid/uuid.dart';

import '../_core.dart';
import '_utils.dart';

class Helpers {
  static String getFileName(File file, {String? prefix}) {
    var name = file.path.split('/').last;
    if (prefix != null) {
      name = "$prefix.${name.split(".").last}";
    }
    return name;
  }

  static launchUrl(String? data) async {
    final launcher = UrlLauncher();

    if (data == null) {
      await launcher.launchURL('https://app.google.io/');
      return;
    }

    if (data.isEmail) {
      await launcher.sendEmail(data);

      return;
    }

    if (data.isPhoneNumber) {
      await launcher.dialPhoneNumber(data);
      return;
    }

    await launcher.launchURL(data);
  }

  static void share(String text) {
    Share.share(text);
  }

  static String generateUniqueId() {
    // Create uuid object
    var uuid = const Uuid();

    return uuid.v1();
  }

  static bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0, int maxLines = 3}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: minWidth,
        maxWidth: window.physicalSize.width,
      );
    return textPainter.didExceedMaxLines;
  }

  static Future copy(String text) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    ).then(
      (value) => CustomDialogs.showToast('Copied to clipboard'),
    );
  }

  static Future<String> deviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (!Platform.isIOS && !Platform.isAndroid) {
      return 'N/A';
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return androidInfo.model;
    }

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.utsname.machine ?? 'N/A';
  }

  static Future<String> get selfIP async {
    final ipv4 = await Ipify.ipv4();

    return ipv4;
  }

  static void launchTelegram(String groupName) async {
    String url = "https://t.me/$groupName";

    if (await launch.canLaunchUrl(Uri.parse(url))) {
      await launch.launchUrl(
        Uri.parse(url),
        mode: launch.LaunchMode.externalApplication,
      );
    }
  }

  static String getTimeAgo(String date) {
    final duration =
        DateTime.now().difference(DateTime.tryParse(date) ?? DateTime.now());
    final fifteenAgo = DateTime.now().subtract(duration);

    return timeago.format(fifteenAgo);
  }
}
