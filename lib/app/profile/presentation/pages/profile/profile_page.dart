import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/profile/domain/models/dtos/profile_option_item_data.dart';
import 'package:triberly/app/profile/presentation/widgets/profile_option_item.dart';
import 'package:triberly/app/profile/presentation/widgets/user_image_with_status_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/data/session_manager.dart';


class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  final user = sl<UserImpDao>().user;

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
        title: 'Profile',
        trailing: Row(
          children: [
            InkWell(
              radius: 20,
              onTap: () {
                context.pushNamed(PageUrl.setupProfilePage);
              },
              child: ImageWidget(
                imageUrl: Assets.svgsProfileEdit,
                size: 24.w,
                fit: BoxFit.scaleDown,
              ),

              // const ImageWidget(
              //   imageUrl: Assets.svgsBackIcon,
              //   fit: BoxFit.scaleDown,
              // ),
            ),
            20.horizontalSpace,
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                 Center(child: UserImageWithStatusWidget(imageUrl:user?.profileImage,)),
                40.verticalSpace,
                 Center(
                  child: TextView(
                    text: "${user?.lastName ?? ''} ${user?.firstName ?? ''}",
                    // text: "Buki Osunkeye, 24",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                10.verticalSpace,
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ImageWidget(
                        imageUrl: Assets.svgsCall,
                        fit: BoxFit.cover,
                        color: Pallets.primary,
                        size: 16,
                        imageType: ImageWidgetType.asset,
                        shape: BoxShape.circle,
                      ),
                      2.horizontalSpace,
                       TextView(
                        // text: "${userDetails?.lastName ?? ''} ${userDetails?.firstName ?? ''}",
                        text: "${user?.phoneNo}",
                        fontSize: 14,
                        color: Pallets.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomDivider()),
                20.verticalSpace,
                Builder(
                  builder: (context) {
                    if (user?.otherImages?.length == 0) {
                      return SizedBox();
                    }
                    return Column(
                      children: [
                        const Row(
                          children: [
                            TextView(
                              text: 'Photos',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                            user?.otherImages?.length ?? 0,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 24.w),
                                child: ImageWidget(
                                  imageUrl:  user?.otherImages?[index].url ?? '',
                                  size: 134.w,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  }
                ),
                20.verticalSpace,
                const _IncognitoSwitcher(),
                20.verticalSpace,
                ...ProfileOptionItemData.profileOptions
                    .map((e) => ProfileOptionItem(
                    leaadingImage: e.leadingImage,
                    tittle: e.title,
                    trailing: e.trailing,
                    onTap: () {
                      e.onTap(context);
                    },
                    hasArrow: e.hasArrow))
                    .toList(),
                23.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () {
                      SessionManager.instance.logOut();
                      context.goNamed(PageUrl.signIn);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageWidget(
                          imageUrl: Assets.svgsLogout,
                          imageType: ImageWidgetType.asset,
                        ),
                        10.horizontalSpace,
                        const Text(
                          'Logout',
                          style: TextStyle(
                              color: Pallets.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                150.verticalSpace,
              ],
            )),
      ),
    );
  }
}

class _IncognitoSwitcher extends StatelessWidget {
  const _IncognitoSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: TextView(
                text: "Incognito mode",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            CupertinoSwitch(
              value: false,

              activeColor: Pallets.primary,
              trackColor: Pallets.grey,
              onChanged: (value) {},
            )
          ],
        ),
        2.verticalSpace,
        const TextView(
          text: "Hide your profile from visibility but still be able to browse",
          style: TextStyle(fontSize: 13, color: Pallets.grey),
        )
      ],
    );
  }
}
