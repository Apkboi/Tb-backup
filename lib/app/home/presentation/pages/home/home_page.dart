import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

import 'home_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _drawerSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _drawerSlideAnimation = Tween<double>(begin: -1, end: 0)
        .chain(
          CurveTween(curve: Curves.elasticOut),
        )
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    dialogKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWithUndeline(
              text: 'New Trybers near you',
            ),
            18.verticalSpace,
            NewTribersRow(),
            21.verticalSpace,
            TextWithUndeline(
              text: 'Explore',
            ),
            16.verticalSpace,
            ExploreCard(),
            150.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      titleWidget: ImageWidget(
        imageUrl: Assets.pngsHomeAppbarTriberly,
        width: 92.w,
        height: 39.h,
      ),
      leading: InkWell(
        onTap: () {
          baseScaffoldKey.currentState?.openDrawer();
        },
        child: ImageWidget(
          imageUrl: Assets.svgsMenuIcon,
          size: 24.w,
          fit: BoxFit.scaleDown,
        ),
      ),
      trailing: Row(
        children: [
          InkWell(
            onTap: () {
              CustomDialogs.showBottomSheet(
                context,
                FilterWidget(),
              );
            },
            child: ImageWidget(
              imageUrl: Assets.svgsFilterIcon,
              size: 24.w,
            ),
          ),
          24.horizontalSpace,
          InkWell(
            onTap: () {
              context.pushNamed(PageUrl.notificationsPage);
            },
            child: ImageWidget(
              imageUrl: Assets.svgsNotification,
              size: 24.w,
            ),
          ),
          20.horizontalSpace,
        ],
      ),
      title: S.of(context).triberly,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size.fromHeight(kBottomNavigationBarHeight + 10);
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    super.key,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String connectType = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .94.sh,
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 24,
                ),
                TextView(
                  text: 'Filters',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                TextView(
                  text: 'Clear',
                  fontSize: 12,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w400,
                  onTap: () {},
                ),
              ],
            ),
            33.verticalSpace,
            TextView(
              text: 'Age',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            16.verticalSpace,
            CustomRangeSlider(),
            32.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Current location',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Original country',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Tribe',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Languages',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Faith',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'Looking to connect with',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                18.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConnectTypeRadio(
                      title: 'Men Only',
                      value: connectType,
                      onTap: () {
                        connectType = 'Men Only';
                        setState(() {});
                      },
                    ),
                    ConnectTypeRadio(
                      title: 'Women Only',
                      value: connectType,
                      onTap: () {
                        connectType = 'Women Only';
                        setState(() {});
                      },
                    ),
                    ConnectTypeRadio(
                      title: 'Anyone',
                      value: connectType,
                      onTap: () {
                        connectType = 'Anyone';
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Intent',
              listItems: [],
              onTap: (value) {},
            ),
            37.verticalSpace,
            ButtonWidget(
              title: 'Done',
              onTap: () {
                context.pop();
              },
            ),
            100.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({super.key, this.start = 30.0, this.end = 50.0});
  final double start;
  final double end;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double _start = widget.start;
    double _end = widget.end;
  }

  double _start = 0;
  double _end = 80;

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: Pallets.primary,
      values: RangeValues(_start, _end),
      labels: RangeLabels(
          "${_start.toInt()} Yrs", '${_end.toInt().toString()} Yrs'),
      onChanged: (value) {
        setState(() {
          _start = value.start;
          _end = value.end;
        });
      },
      min: 0.0,
      max: 100.0,
    );
  }
}

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.profileDetails);
      },
      child: Stack(
        children: [
          ImageWidget(
            imageUrl: Assets.pngsMale,
            height: 490.h,
            width: 1.sw,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(15),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: .5.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xffEF0096).withOpacity(.4),
                    Color(0xffEF0096).withOpacity(.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: 'Bruno, 28',
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Pallets.white,
                    ),
                    Row(
                      children: [
                        ImageWidget(
                          imageUrl: Assets.svgsHome,
                          size: 15,
                          color: Pallets.white,
                        ),
                        6.horizontalSpace,
                        TextView(
                          text: 'Nigeria',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Pallets.white,
                        ),
                      ],
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: 'Searching for: Travel buddies',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Pallets.white,
                    ),
                    Row(
                      children: [
                        ImageWidget(
                          imageUrl: Assets.svgsLogoWhite,
                          size: 15,
                          color: Pallets.white,
                        ),
                        6.horizontalSpace,
                        TextView(
                          text: 'Igbo',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Pallets.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewTribersRow extends StatelessWidget {
  const NewTribersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) => NewTribersBox(
            name: "Peter tere",
            distance: '10',
          ),
        ),
      ),
    );
  }
}

class NewTribersBox extends StatelessWidget {
  const NewTribersBox({
    super.key,
    this.name,
    this.image,
    this.distance,
  });

  final String? name;
  final String? image;
  final String? distance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.profileDetails);
      },
      child: Container(
        margin: EdgeInsets.only(right: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: 195,
        decoration: BoxDecoration(
          color: Pallets.primaryLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ImageWidget(imageUrl: Assets.svgsRing),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ImageWidget(
                      imageUrl: image ?? Assets.pngsMale,
                      size: 40,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
            13.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: name ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  7.5.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.svgsRouting),
                      5.horizontalSpace,
                      Expanded(
                        child: TextView(
                          text: "${distance ?? '-'} km away",
                          fontSize: 12,
                          color: Pallets.grey,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithUndeline extends StatelessWidget {
  const TextWithUndeline({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        5.verticalSpace,
        Container(
          width: 89.w,
          height: 2,
          color: Pallets.primary,
        )
      ],
    );
  }
}
