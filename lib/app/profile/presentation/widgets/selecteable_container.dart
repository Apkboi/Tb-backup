import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

class SelectableContainer extends StatelessWidget {
  final SelectionModel reason;
  final bool isSelected;
  final VoidCallback onTap;

  SelectableContainer(
      {super.key, required this.reason, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Pallets.primary : Pallets.grey,
            width: isSelected ?1.w:0.5.w,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        duration: const Duration(milliseconds: 300),
        child: Text(
          reason.index == 0
              ? "I don’t find ${S.of(context).triberly} useful"
              : reason.title,
          style: const TextStyle(),
        ),
      ),
    );
  }
}


class SelectionModel {
  final int index;
  final String title;

  SelectionModel({required this.index, required this.title});
}

