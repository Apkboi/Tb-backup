import 'package:flutter/material.dart';
import 'package:triberly/core/shared/text_view.dart';

import '../../../../core/constants/pallets.dart';

class MessageRetryWidget extends StatelessWidget {
  const MessageRetryWidget({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextView(
          text: "Couldn't send message",
          color: Pallets.red,
        ),
        TextButton(
            style: TextButton.styleFrom(
                shape:
                    const StadiumBorder(side: BorderSide(color: Pallets.red))),
            onPressed: () {
              onRetry();
            },
            child: const TextView(
              text: "Retry",
              color: Pallets.red,
            )),
      ],
    );
  }
}
