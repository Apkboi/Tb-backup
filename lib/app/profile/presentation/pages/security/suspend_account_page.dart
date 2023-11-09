import 'package:flutter/material.dart';
import 'package:triberly/app/profile/domain/models/dtos/delete_account_reason.dart';

import 'package:triberly/core/_core.dart';

class SuspendAccountPage extends StatefulWidget {
  const SuspendAccountPage({Key? key}) : super(key: key);

  @override
  State<SuspendAccountPage> createState() => _SuspendAccountPageState();
}

class _SuspendAccountPageState extends State<SuspendAccountPage> {
  List<DeleteAccountReason> deleteReasons = [
    DeleteAccountReason(id: 1, title: "I don’t find triberly useful"),
    DeleteAccountReason(id: 2, title: "I couldn’t achieve my aim of using the app"),
    DeleteAccountReason(id: 3, title: "Your charges are too high"),
    DeleteAccountReason(id: 4, title: "Others"),
    // Add more reasons as needed
  ];

  int selectedReasonId = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:const CustomAppBar(title: "Suspend/Delete Account"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const   TextView(
                text: "We’re sad to see you go, we would like to know your reason for making this decision (optional)",
                style: TextStyle(fontSize: 16, color: Pallets.grey),
              ),
              20.verticalSpace,
              ...deleteReasons.map((reason) {
                final isSelected = reason.id == selectedReasonId;
                return _CustomReasonItem(
                  reason: reason,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedReasonId = isSelected ? 0 : reason.id; // Toggle selection
                    });
                  },
                );
              }).toList(),

            ],
          ),
        ),
      ),
    );
  }
}

class _CustomReasonItem extends StatelessWidget {
  final DeleteAccountReason reason;
  final bool isSelected;
  final VoidCallback onTap;

  _CustomReasonItem(
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
          reason.id == 0
              ? "I don’t find ${S.of(context).triberly} useful"
              : reason.title,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
