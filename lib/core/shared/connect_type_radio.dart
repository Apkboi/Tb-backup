import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

class ConnectTypeRadio extends StatelessWidget {
  const ConnectTypeRadio({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Pallets.primary,
          ),
          color: title == value ? Pallets.primary : Pallets.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 7),
        alignment: Alignment.center,
        child: TextView(
          text: title,
          fontSize: 12,
          color: title == value ? Pallets.white : Pallets.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
