import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
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
  }

  @override
  void dispose() {
    dialogKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWithUndeline(
              text: 'New Trybers near you',
            ),
            18.verticalSpace,
            const NewTribersRow(),
            21.verticalSpace,
            const TextWithUndeline(
              text: 'Explore',
            ),
            16.verticalSpace,
            SizedBox(
              height: .6.sh,
              width: 1.sw,
              child: AppinioSwiper(
                padding: EdgeInsets.zero,
                loop: true,
                cardsCount: 10,
                onSwiping: (AppinioSwiperDirection direction) {
                  print(direction.toString());
                },
                cardsBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    // height: .6.sh,
                    child: ExploreCard(
                      name: 'Tam $index',
                      age: '${(index + 12) * 2}',
                    ),
                  );
                },
              ),
            ),
            150.verticalSpace,
          ],
        ),
      ),
    );
  }
}
