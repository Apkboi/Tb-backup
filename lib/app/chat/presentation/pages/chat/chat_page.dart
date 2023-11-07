import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/chat/domain/models/dtos/get_chats_res_dto.dart';
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
  void didUpdateWidget(covariant ChatPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    getOngoingChats();
  }

  @override
  void initState() {
    super.initState();
    getOngoingChats();
  }

  getOngoingChats() {
    Future.delayed(Duration.zero, () {
      ref.read(chatProvider.notifier).getChats();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatsList = ref.watch(chatProvider.notifier).chatSearchResults;

    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Chats',
      ),
      body: Builder(builder: (context) {
        final state = ref.watch(chatProvider);

        if (state is ChatLoading) {
          return CustomDialogs.getLoading(size: 50);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                onChanged: (val) {
                  _searchForChat(val, ref);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 10),
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    await getOngoingChats();
                  },
                  child: ListView.separated(
                    itemCount: chatsList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 150.h),
                    itemBuilder: (context, index) {
                      final singleItem = chatsList[index];
                      return ChatTile(
                        chatData: singleItem,
                        userDto: singleItem.participants?.firstOrNull?.user,
                        onTap: () {
                          context.pushNamed(
                            PageUrl.chatDetails,
                            queryParameters: {
                              PathParam.chatId: "${singleItem.id}",
                              PathParam.userName:
                                  "${singleItem.participants?.firstOrNull?.user?.lastName} ${singleItem.participants?.firstOrNull?.user?.firstName}",
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CustomDivider(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _searchForChat(String val, WidgetRef ref) {
    Debouncer().call(() {
      ref.read(chatProvider.notifier).searchForChat(val);
    });
  }
}

// List<ChatData> filteredChatsList(List<ChatData> chatsList ){
//
//
//
//
//   return
// }

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    this.onTap,
    required this.userDto,
    required this.chatData,
  });

  final VoidCallback? onTap;
  final UserDto? userDto;
  final ChatData? chatData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWidget(
            imageUrl: userDto?.profileImage ?? '',
            size: 61,
            borderRadius: BorderRadius.circular(12),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextView(
                              text:
                                  '${userDto?.lastName ?? ''} ${userDto?.firstName ?? ''}, ${Helpers.calculateAge(userDto?.dob ?? '').toLowerCase() ?? ''}',
                              fontSize: 16,
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          12.horizontalSpace,
                          const Icon(
                            Icons.circle,
                            color: Pallets.primary,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                    TextView(
                      text: TimeUtil.getTimeAgo(chatData?.timestamp),
                      fontSize: 12,
                      color: Pallets.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                4.verticalSpace,
                TextView(
                  text: chatData?.lastMessage ?? '',
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
