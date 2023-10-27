import 'dart:math';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/pages/location/location_controller.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

import '../../widgets/_home_widgets.dart';
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

  @override
  void initState() {
    super.initState();
    getConnections();
  }

  getConnections() {
    Future.delayed(Duration.zero, () {
      ref.read(homeProvider.notifier).caller(SearchConnectionsReqDto());
      ref.read(homeProvider.notifier).clearFilter();
      ref.read(setupProfileProvider.notifier).getDataConfigs();
      ref.read(locationProvider.notifier).caller();
    });
  }

  @override
  void dispose() {
    dialogKey.currentState?.dispose();

    super.dispose();
  }

  List<UserDto> randomUsers = [];
  List<UserDto> latLngUsers = [];
  @override
  Widget build(BuildContext context) {
    ///
    final state = ref.watch(homeProvider);

    ///

    ref.listen(homeProvider, (previous, next) {
      if (next is HomeSuccess) {
        randomUsers = ref.watch(homeProvider.notifier).randomUsers;
        latLngUsers = ref.watch(homeProvider.notifier).latLngUsers;

        if (randomUsers.isEmpty && latLngUsers.isEmpty) {
          CustomDialogs.error(
            'No users fit the current data, try adjusting the filter',
          );
          CustomDialogs.showBottomSheet(
            scaffoldKey.currentState!.context,
            FilterWidget(),
          );
        }
      }
    });
    return Scaffold(
      key: scaffoldKey,
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          getConnections();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWithUndeline(
                text: 'New Trybers near you',
              ),
              18.verticalSpace,
              if (state is HomeLoading)
                CustomDialogs.getLoading(size: 20)
              else
                NewTribersRow(users: latLngUsers),
              21.verticalSpace,
              const TextWithUndeline(
                text: 'Explore',
              ),
              16.verticalSpace,
              if (state is HomeLoading)
                CustomDialogs.getLoading(size: 50)
              else
                SizedBox(
                  height: .6.sh,
                  width: 1.sw,
                  child: AppinioSwiper(
                    padding: EdgeInsets.zero,
                    backgroundCardsCount: 2,
                    loop: randomUsers.isEmpty ? false : true,
                    cardsCount: randomUsers.length,
                    onSwiping: (AppinioSwiperDirection direction) {
                      print(direction.toString());
                    },
                    cardsBuilder: (BuildContext context, int index) {
                      final singleItem = randomUsers[index];
                      return SizedBox(
                        child: ExploreCard(
                          user: singleItem,
                          name:
                              "${singleItem.firstName ?? ''} ${singleItem.lastName ?? ''}",
                          age: singleItem.dob ?? 'n/a',
                          intent: '${singleItem.intent ?? 'n/a'}',
                          tribe: '${singleItem.tribes ?? 'n/a'}',
                          image: singleItem.profileImage,
                          country: 'Nigeria',
                        ),
                      );
                    },
                  ),
                ),
              150.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
