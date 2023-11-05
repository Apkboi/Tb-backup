import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/community/dormain/models/dtos/get_connections_res_dto.dart';
import 'package:triberly/app/community/presentation/pages/community/community_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }
  
  @override
  void initState() {
   _getConnections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Connections',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                final state = ref.watch(communityProvider);

                if (state is ConnectionsLoading) {
                  return CustomDialogs.getLoading(size: 50);
                }

                final connectionsList =
                    ref.watch(communityProvider.notifier).userConnections?.data;

                return (connectionsList?.isNotEmpty ?? false)
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 150),
                        itemCount: 15,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: .7,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return  ConnectionsCard(connection: connectionsList![index],);
                        },
                      )
                    : const Center(
                        child: EmptyState(
                        imageUrl: "imageUrl",
                        title: "No connections to show",
                        subtitle:
                            "You don’t have any connections yet. Once you connect with someone it will show here.",
                      ));
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _getConnections() {

      Future.delayed(Duration.zero, () {
        ref.read(communityProvider.notifier).getConnections();
      });
    
  }
}

class ConnectionsCard extends StatelessWidget {
  final UserConnection connection;
  const ConnectionsCard({
    super.key, required this.connection,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () {
            context.pushNamed(
              PageUrl.profileDetails,
              // queryParameters: {PathParam.userId: user.id},
            );
          },
          child: Stack(
            children: [
              ImageWidget(
                imageUrl: Assets.pngsMale,
                height: 490.h,
                width: 1.sw,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(20),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: .2.sw,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xffEF0096).withOpacity(.3),
                        Color(0xffEF0096).withOpacity(.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 17,
                left: 16,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Martins ,",
                          style: ref
                              .read(themeProvider)
                              .selectedTextTheme
                              .bodySmall
                              ?.copyWith(
                                fontSize: 15,
                                color: Pallets.white,
                                fontWeight: FontWeight.w600,
                              ),
                          children: [
                            TextSpan(
                              text: '36',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context
                                    .pushReplacementNamed(PageUrl.signUp),
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Pallets.white,
                              ),
                            ),
                          ]),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 7,
                        ),
                        7.horizontalSpace,
                        TextView(
                          text: 'Last seen 4h ago',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Pallets.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
