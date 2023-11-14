import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_controller.dart';
import 'package:triberly/core/constants/pallets.dart';
import 'package:triberly/core/shared/text_view.dart';

class ReplyingMessageWidget extends ConsumerStatefulWidget {
  const ReplyingMessageWidget({super.key,});



  @override
  ConsumerState<ReplyingMessageWidget> createState() =>
      _ReplyingMessageWidgetState();
}

class _ReplyingMessageWidgetState extends ConsumerState<ReplyingMessageWidget> {
  @override
  Widget build(BuildContext context) {
    final replyingMessage =
        ref.watch(chatDetailsProvider.notifier).replyingMessage;
    return replyingMessage != null
        ? Container(
            color: Pallets.grey.withOpacity(0.1),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 3,
                      color: Pallets.black,
                    ),
                    16.horizontalSpace,
                    TextView(
                        text: ref.watch(chatDetailsProvider.notifier)
                                .replyingMessage
                                ?.message ??
                            ''),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      ref.watch(chatDetailsProvider.notifier).replyingMessage =
                          null;
                    });
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Pallets.primary,
                  ),
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
