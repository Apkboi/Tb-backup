import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/profile/domain/models/dtos/delete_account_reason.dart';
import 'package:triberly/app/profile/presentation/controllers/security_controller.dart';

import 'package:triberly/core/_core.dart';

class SuspendAccountPage extends ConsumerStatefulWidget {
  const SuspendAccountPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SuspendAccountPage> createState() => _SuspendAccountPageState();
}

class _SuspendAccountPageState extends ConsumerState<SuspendAccountPage> {
  List<DeleteAccountReason> deleteReasons = [
    DeleteAccountReason(id: 1, title: "I don’t find triberly useful"),
    DeleteAccountReason(
        id: 2, title: "I couldn’t achieve my aim of using the app"),
    DeleteAccountReason(id: 3, title: "Your charges are too high"),
    DeleteAccountReason(id: 4, title: "Others"),
    // Add more reasons as needed
  ];

  int selectedReasonId = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.listen(securityProvider, (previous, next) {
        if (next is DeleteAccountLoading) {
          CustomDialogs.showLoading(context);
        }

        if (next is DeleteAccountError) {
          CustomDialogs.hideLoading(context);
          CustomDialogs.error(next.message);
        }
        if (next is DeleteAccountSuccess) {
          CustomDialogs.hideLoading(context);
          CustomDialogs.success('Your delete account request has been sent.');
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Suspend/Delete Account"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const TextView(
                text:
                    "We’re sad to see you go, we would like to know your reason for making this decision (optional)",
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
                      selectedReasonId =
                          isSelected ? 0 : reason.id; // Toggle selection
                    });
                  },
                );
              }).toList(),
              20.verticalSpace,
              ButtonWidget(
                onTap: selectedReasonId != 0
                    ? () {
                        CustomDialogs.showConfirmDialog(context,
                            message:
                                "Are you sure you want to delete account ?",
                            onYes: () async {
                          // CustomDialogs.hideLoading(context);
                          deleteAccount(context);
                        });
                      }
                    : null,
                title: "Delete account",
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    // Navigator.pop(context);
    try {
      Navigator.pop(rootNavigatorKey.currentState!.context);

      CustomDialogs.showLoading(context);

      await ref.read(securityProvider.notifier).deleteAccount(deleteReasons
          .where((element) => element.id == selectedReasonId)
          .first
          .title);

      Navigator.pop(rootNavigatorKey.currentState!.context);
      Navigator.pop(context);

      CustomDialogs.success(
          'Your delete account request has been sent, you will get a response within 24hours.');
    } on Exception catch (e) {
      Navigator.pop(rootNavigatorKey.currentState!.context);
    }
  }
}

class _CustomReasonItem extends StatelessWidget {
  final DeleteAccountReason reason;
  final bool isSelected;
  final VoidCallback onTap;

  _CustomReasonItem(
      {super.key,
      required this.reason,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Pallets.primary : Pallets.grey,
            width: isSelected ? 1.w : 0.5.w,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20.0),
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
