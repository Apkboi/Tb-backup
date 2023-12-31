import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/presentation/pages/chat/chat_controller.dart';
import 'package:triberly/app/community/presentation/widgets/connection_request_dialog.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/app/profile/presentation/widgets/bookmark_button.dart';
import 'package:triberly/app/profile/presentation/widgets/favorite_button.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/core/shared/left_right_widget.dart';

import '../../../../../core/_core.dart';
import 'profile_details_controller.dart';

class ProfileDetailsPage extends ConsumerStatefulWidget {
  const ProfileDetailsPage({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends ConsumerState<ProfileDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  List records = [
    ('Profession', 'Marketing Automation'),
    ('Gender', 'Male'),
    ('Relationship Status', 'Married'),
    ('Looking for', ' Business networking'),
    ('Origin Country', 'Nigeria'),
    ('Other Nationality', 'British'),
    ('Mother Tongue', 'Igbo'),
    (
      'Bio',
      'My name is Bruno Charles and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy travelling as well.'
    ),
    ('Interests', ['Travelling', 'Books']),
    ('Faith', 'Pentecostal'),
    ('Education', 'Masters degree'),
    ('Hashtags', '#Odogwu'),
  ];

  String? _requestMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  _getUserData() {
    Future.delayed(Duration.zero, () {
      ref
          .read(profileDetailsProvider.notifier)
          .getUserDetailsMain(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatProvider, (previous, next) {
      if (next is InitialiseChatLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is ChatError) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
        return;
      }

      if (next is InitialiseChatSuccess) {
        ref.read(chatProvider.notifier).getChats();
        context.pop();

        final userDetails =
            ref.watch(profileDetailsProvider.notifier).userDetails;
        final chatId = ref.watch(chatProvider.notifier).initiatedChat?.id;
        _sendInitialMessage(chatId ?? 0);
        context.pushNamed(
          PageUrl.chatDetails,
          queryParameters: {
            PathParam.chatId: "$chatId",
            PathParam.userName:
                "${userDetails?.lastName ?? ''} ${userDetails?.firstName ?? ''}",
          },
        );
        return;
      }
    });
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Builder(builder: (context) {
          if (ref.watch(profileDetailsProvider) is ProfileDetailsLoading) {
            return CustomDialogs.getLoading(size: 50);
          }

          final userDetails =
              ref.watch(profileDetailsProvider.notifier).userDetails;

          final userCountry = ref
                  .read(setupProfileProvider.notifier)
                  .countries
                  .firstWhereOrNull((element) =>
                      element.id == userDetails?.residenceCountryId?.id)
                  ?.name ??
              'N/A';
          final originCountry = ref
                  .read(setupProfileProvider.notifier)
                  .countries
                  .firstWhereOrNull(
                      (element) => element.id == userDetails?.originCountryId)
                  ?.name ??
              'N/A';

          records = [
            ('Profession', '${userDetails?.profession ?? '-'}'),
            ('Gender', '${userDetails?.gender ?? ''}'),
            (
              'Relationship Status',
              '${userDetails?.relationshipStatus ?? '-'}'
            ),
            ('Looking for', userDetails?.intent ?? "-"),
            ('Origin Country', originCountry),
            ('Other Nationality', userCountry),
            ('Mother Tongue', '${userDetails?.town ?? '-'}'),
            ('Bio', '${userDetails?.bio ?? '-'}'),
            (
              'Interests',
              userDetails?.interests != null
                  ? (userDetails!.interests)
                      .toString()
                      .split(", ")
                      .map((e) =>
                          ref.watch(interestByIdProvider(int.parse(e)))?.name)
                      .toList()
                      .join(", ")
                  : "-",
            ),
            ('Faith', '-'),
            ('Education', '-'),
            ('Hashtags', '-'),
          ];

          // logger.log(Logger.level, 'TRIBE ${userDetails?.tribes ?? 'N/A'}');

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      radius: 20,
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Pallets.maybeBlack,
                        opticalSize: 24,
                        size: 24,
                      ),
                    ),
                    InkWell(
                      radius: 20,
                      onTap: () {
                        context.pop();
                      },
                      child: const ImageWidget(imageUrl: Assets.svgsMore),
                    ),
                  ],
                ),
                Container(
                  height: 120.w,
                  width: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Pallets.primaryDark,
                      width: 2,
                    ),
                  ),
                  child: ImageWidget(
                    imageUrl: userDetails?.profileImage ?? '',
                    size: 100.w,
                    fit: BoxFit.cover,
                    shape: BoxShape.circle,
                  ),
                ),
                23.verticalSpace,
                TextView(
                  text:
                      "${userDetails?.lastName ?? ''} ${userDetails?.firstName ?? ''}",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BookmarkButton(userDetails?.id.toString()??''),
                    ShadowCircleContainer(
                      size: 80,
                      color: Pallets.primary,
                      child: ref
                              .read(chatProvider.notifier)
                              .isConnectedToUser(userDetails?.email??"")
                          ? const ImageWidget(
                              imageUrl: Assets.svgsChat,
                              color: Pallets.white,
                            )
                          : const ImageWidget(
                              imageUrl: Assets.svgsLink,
                              color: Pallets.white,
                            ),
                      onTap: () {
                        if (ref
                            .read(chatProvider.notifier)
                            .isConnectedToUser(userDetails?.email)) {
                          ref
                              .read(chatProvider.notifier)
                              .initiateChat(userDetails!.id.toString());
                        } else {
                          CustomDialogs.showCustomDialog(
                              ConnectionRequestDialog(
                                userDetails!,
                                onRequestSent: (String? message) {
                                  _requestMessage = message;
                                  ref
                                      .read(chatProvider.notifier)
                                      .initiateChat(userDetails.id.toString());
                                },
                              ),
                              context);
                        }

                        // ref
                        //     .read(chatProvider.notifier)
                        //     .initiateChat(widget.userId);
                      },
                    ),
                    FavoriteButton(userDetails?.id.toString()??''),
                  ],
                ),
                26.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserUpDownWidget(
                      title: 'Tribe',
                      value: userDetails?.tribes == null
                          ? "N/A"
                          : userDetails!.tribes is List
                              ? (userDetails.tribes as List)
                                  .map((e) => ref
                                      .watch(tribeByIdProvider(int.parse(e)))
                                      ?.name)
                                  .toList()
                                  .join(", ")
                              : ref
                                  .watch(tribeByIdProvider(int.parse(
                                      userDetails.tribes.toString())))!
                                  .name!,
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      color: Pallets.grey,
                    ),
                    UserUpDownWidget(
                      title: 'Location',
                      value: ref
                              .read(setupProfileProvider.notifier)
                              .countries
                              .firstWhereOrNull((element) =>
                                  element.id ==
                                  userDetails?.residenceCountryId?.id)
                              ?.name ??
                          'N/A',
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      color: Pallets.grey,
                    ),
                    UserUpDownWidget(
                      title: 'Age',
                      value:
                          Helpers.calculateAge(userDetails?.dob ?? '') ?? "N/A",
                    ),
                  ],
                ),
                24.verticalSpace,
                const CustomDivider(),
                24.verticalSpace,
                Builder(builder: (context) {
                  if (userDetails?.otherImages?.length == 0) {
                    return SizedBox();
                  }

                  return Column(
                    children: [
                      const Row(
                        children: [
                          TextView(
                            text: 'Photos',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            userDetails?.otherImages?.length ?? 0,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 24.w),
                              child: ImageWidget(
                                imageUrl:
                                    userDetails?.otherImages?[index].url ?? '',
                                size: 134.w,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                24.verticalSpace,
                ...records.map((e) {
                  if (e.$2 is List<String>) {
                    return LeftRightWidget(
                      title: e.$1,
                      value: (e.$2 as List).isNotEmpty
                          ? (e.$2 as List).join(', ')
                          : "-",
                    );
                  }
                  // logger.log(Level.debug, "${e.$1}${e.$2}");

                  return LeftRightWidget(
                    title: e.$1,
                    value: e.$2,
                  );
                }).toList(),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _sendInitialMessage(num chatId) {
    if (_requestMessage != null) {
      final userDto = sl<UserImpDao>().user;
      DatabaseReference dbRef = FirebaseDatabase.instance.ref();

      final data = MessageModel(
        message: _requestMessage,
        senderId: userDto?.id.toString(),
        isMe: true,
        repliedMessage: null,
        date: DateTime.now().toString(),
        timestamp: ServerValue.timestamp,
      );

      if (data.message != '') {
        dbRef
            .child("chat_messages")
            .child(chatId.toString())
            .push()
            .set(data.toMap())
            .then(
              (value) {},
            );
      }
      _requestMessage = null;
    }
  }
}

class ShadowCircleContainer extends StatelessWidget {
  const ShadowCircleContainer({
    super.key,
    this.size = 60,
    this.color,
    required this.child,
    this.onTap,
  });

  final double size;
  final Color? color;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.w,
        height: size.w,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color ?? Pallets.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Pallets.primary.withOpacity(0.15),
              blurRadius: 15,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class UserUpDownWidget extends StatelessWidget {
  const UserUpDownWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextView(
          text: title,
          fontSize: 14,
          color: Pallets.grey,
          fontWeight: FontWeight.w400,
        ),
        TextView(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
