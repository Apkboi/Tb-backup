import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/navigation/path_params.dart';

import 'chat_controller.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Chats',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 10),
                  child: ImageWidget(
                    imageUrl: Assets.svgsSearchNormal,
                    size: 24,
                  ),
                ),
                fillColor: Pallets.searchGrey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none),
              ),
            ),
            17.verticalSpace,
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 150.h),
                itemBuilder: (contex, index) {
                  return ChatTile(
                    onTap: () {
                      context.pushNamed(
                        PageUrl.chatDetails,
                        queryParameters: {
                          PathParam.chatId: '1',
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomDivider(),
                ),
                itemCount: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWidget(
            imageUrl: Assets.pngsMale,
            size: 61,
            borderRadius: BorderRadius.circular(12),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextView(
                          text: 'Bruno Charles, 32',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        12.horizontalSpace,
                        Icon(
                          Icons.circle,
                          color: Pallets.primary,
                          size: 10,
                        )
                      ],
                    ),
                    TextView(
                      text: '15 min',
                      fontSize: 12,
                      color: Pallets.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                4.verticalSpace,
                TextView(
                  text:
                      'I’m on my way to the restaurant for our date. Keep in touch',
                  fontSize: 12,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
