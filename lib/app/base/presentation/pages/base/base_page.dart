import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';

import 'base_controller.dart';

List<int> _list = [];

final GlobalKey<ScaffoldState> baseScaffoldKey = GlobalKey<ScaffoldState>();

class BasePage extends ConsumerStatefulWidget {
  const BasePage({
    super.key,
    this.passedIndex = 0,
    required this.navigationShell,
  });

  final int passedIndex;

  final StatefulNavigationShell navigationShell;
  @override
  ConsumerState createState() => _BasePageState();
}

class _BasePageState extends ConsumerState<BasePage> {
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  void _goBranch(int index) {
    if (index != 1) {
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: baseScaffoldKey,
      drawer: const DrawerWidget(),
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(13, 0, 13, 35),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 55,
              color: Colors.black.withOpacity(0.15),
            ),
            BoxShadow(
              blurRadius: 100,
              color: Colors.black.withOpacity(0.15),
            ),
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: widget.navigationShell.currentIndex,
              onTap: _goBranch,
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: const ImageWidget(imageUrl: Assets.svgsHome, size: 30),
                  activeIcon: ImageWidget(
                      imageUrl: Assets.svgsHomeSelected, size: 58.w),
                ),
                BottomNavigationBarItem(
                  label: 'Community',
                  icon: ImageWidget(imageUrl: Assets.svgsLink, size: 30.w),
                  activeIcon: ImageWidget(
                      imageUrl: Assets.svgsLinkSelected, size: 58.w),
                ),
                BottomNavigationBarItem(
                  label: 'Chat',
                  icon: ImageWidget(imageUrl: Assets.svgsChat, size: 30.w),
                  activeIcon: ImageWidget(
                      imageUrl: Assets.svgsChatSelected, size: 58.w),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: ImageWidget(imageUrl: Assets.svgsProfile, size: 30.w),
                  activeIcon: ImageWidget(
                      imageUrl: Assets.svgsProfileSelected, size: 58.w),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<double>(begin: -0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final user = sl<UserImpDao>().user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          65.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => context.pop(),
                child: Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: const BoxDecoration(
                    color: Pallets.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.xmark,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          32.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageWidget(
                imageUrl: user?.profileImage ?? '',
                size: 48.dm,
                borderRadius: BorderRadius.circular(24),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text:
                          "${user?.lastName ?? 'N/A'} ${user?.firstName ?? 'N/A'} ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    TextView(
                      text: user?.email ?? 'N/A',
                      fontSize: 12,
                      color: Pallets.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          44.verticalSpace,
          DrawerTile(
            title: 'My Profile',
            icon: Assets.svgsProfileDrawer,
            index: 0,
            trailing: Container(
              decoration: BoxDecoration(
                color: Pallets.white,
                borderRadius: BorderRadius.circular(2),
              ),
              width: 20.w,
              alignment: Alignment.center,
              height: 20.w,
              child: const TextView(
                text: '2',
                color: Pallets.primary,
              ),
            ),
            onTap: () {},
          ),
          const DrawerTile(
            index: 1,
            title: 'My Tribers',
            icon: Assets.svgsCategory,
          ),
          const DrawerTile(
            index: 2,
            title: 'My Tribers',
            icon: Assets.svgsCategory,
          ),
          const DrawerTile(
            index: 3,
            title: 'Community Boards',
            icon: Assets.svgsCategory,
          ),
          const DrawerTile(
            index: 4,
            title: 'Find a Host',
            icon: Assets.svgsGlobalSearch,
          ),
          const DrawerTile(
            index: 5,
            title: 'Find a Service',
            icon: Assets.svgsSearchStatus,
          ),
          const DrawerTile(
            index: 6,
            title: 'Refer a Friend',
            icon: Assets.svgsProfile2user,
          ),
          const DrawerTile(
            index: 7,
            title: 'Upgrade my Account',
            icon: Assets.svgsCrown,
          ),
          const DrawerTile(
            index: 8,
            title: 'Contact Us',
            icon: Assets.svgsCall,
          ),
          DrawerTile(
            index: 9,
            title: 'Log Out',
            isLogout: true,
            icon: Assets.svgsLogout,
            onTap: () {
              _list.clear();
              SessionManager.instance.logOut();
              context.goNamed(PageUrl.signIn);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    this.selected = false,
    this.isLogout = false,
    this.trailing,
    required this.icon,
    required this.title,
    this.onTap,
    required this.index,
  });

  final bool selected;
  final int index;
  final bool isLogout;
  final Widget? trailing;
  final String icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        minLeadingWidth: 0,
        leading: ImageWidget(
          imageUrl: icon,
          size: 24,
          color: isLogout
              ? Pallets.red
              : _list.contains(index)
                  ? Pallets.white
                  : Pallets.grey,
        ),
        trailing: trailing,
        selected: _list.contains(index),
        selectedColor: Pallets.white,
        selectedTileColor: Pallets.primary,
        title: TextView(
          text: title,
          fontSize: 16,
          color: isLogout
              ? Pallets.red
              : _list.contains(index)
                  ? Pallets.white
                  : Pallets.grey,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          _list.clear();
          _list.add(index);
          onTap?.call();
          context.pop();
        },
      ),
    );
  }
}
