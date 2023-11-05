import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/community/presentation/pages/community/community_controller.dart';
import 'package:triberly/core/_core.dart';

class ConnectionRequestDialog extends ConsumerWidget {
  ConnectionRequestDialog(this.userDetails, {Key? key}) : super(key: key);
  final messageController = TextEditingController();
  final UserDto userDetails;

  @override
  Widget build(BuildContext context, ref) {
    _listenToConnectionStates(context, ref);
    final state = ref.watch(communityProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Pallets.grey,
              ),
            ),
          ),
          Center(
            child: ImageWidget(
              imageUrl: Assets.pngsChain,
              color: Pallets.pinkLight,
              size: 40,
              height: 65.h,
              width: 58.w,
              fit: BoxFit.contain,
            ),
          ),
          18.verticalSpace,
          const TextView(
            text: "Request to connect?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          8.verticalSpace,
          TextView(
            text:
                "You are about to send a connection request to ${userDetails.firstName}, you will become Trybers when they accept your request.",
            style: const TextStyle(
                fontSize: 14, color: Pallets.grey, fontWeight: FontWeight.w500),
          ),
          24.verticalSpace,
          const TextView(
            text: "Add a message (optional)",
            style: TextStyle(
              fontSize: 13,
              color: Pallets.grey,
            ),
          ),
          8.verticalSpace,
          TextBoxField(
            controller: messageController,
            hintText: "Type here",
          ),
          22.verticalSpace,
          ButtonWidget(
            onTap: () {
              ref.read(communityProvider.notifier).saveConnection(
                  userDetails.id.toString(), messageController.text);
            },
            title: 'Send request',
            loading: state is SaveConnectionLoading,
          ),
          22.verticalSpace,
        ],
      ),
    );
  }

  void _listenToConnectionStates(BuildContext context, WidgetRef ref) {
    ref.listen(communityProvider, (previous, next) {
      if (next is SaveConnectionSuccess) {
        CustomDialogs.showFlushBar(context, 'Connection request sent.');
        Navigator.pop(context);
      }
      if (next is SaveConnectionError) {
        CustomDialogs.showFlushBar(context, next.message,
            isError: true);
        Navigator.pop(context);
      }
    });
  }
}
