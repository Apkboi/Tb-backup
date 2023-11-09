import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';

List<Interests> selectedIntrestChips = [];
List<String> selectedHastagChips = [];

class InterestsTab extends ConsumerStatefulWidget {
  const InterestsTab({super.key});

  @override
  ConsumerState createState() => _InterestsTabState();
}

class _InterestsTabState extends ConsumerState<InterestsTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController intentCtrl = TextEditingController();

  @override
  void dispose() {
    intentCtrl.dispose();

    super.dispose();
  }

  String connectType = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          21.verticalSpace,
          // const TextView(
          //   text: 'Interests',
          //   fontSize: 20,
          //   fontWeight: FontWeight.w600,
          // ),
          // 8.verticalSpace,
          const TextView(
            text:
                'Add a bit more to enable us match with other Tribers with similar background.',
            fontSize: 14,
            color: Pallets.grey,
          ),
          24.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: 'Looking to connect with',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              16.verticalSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ConnectTypeRadio(
              //       title: 'Men Only',
              //       value: connectType,
              //       onTap: () {
              //         connectType = 'Men Only';
              //         setState(() {});
              //       },
              //     ),
              //     ConnectTypeRadio(
              //       title: 'Women Only',
              //       value: connectType,
              //       onTap: () {
              //         connectType = 'Women Only';
              //         setState(() {});
              //       },
              //     ),
              //     ConnectTypeRadio(
              //       title: 'Anyone',
              //       value: connectType,
              //       onTap: () {
              //         connectType = 'Anyone';
              //         setState(() {});
              //       },
              //     ),
              //   ],
              // ),
              FilterCustomDropDown(
                hintText: "Who are you looking to connect to ?",
                selectedValue: connectType,
                listItems: const ['Men Only', 'Women Only', "Anyone"],
                onTap: (value) {
                  connectType = value ?? '';
                },
                hasValidator: true,
              ),
            ],
          ),
          16.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterCustomDropDown(
                hintText: "Intent",
                selectedValue: intentCtrl.text,
                listItems: const [
                  'Love and Romance',
                  'College',
                  "Host friends",
                  "Business partners",
                  "Find new friends"
                ],
                onTap: (value) {
                  intentCtrl.text = value ?? '';
                },
                hasValidator: true,
              ),
              const TextView(
                text: 'The hashtag that fits my life (optional)',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const TextView(
                text: 'Select 3 or more',
                fontSize: 12,
                color: Pallets.grey,
                fontWeight: FontWeight.w600,
              ),
              24.verticalSpace,
              LifeChipsList(),
              32.verticalSpace,
              const TextView(
                text: 'Interests',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const TextView(
                text: 'Select 3 or more',
                fontSize: 12,
                color: Pallets.grey,
                fontWeight: FontWeight.w600,
              ),
              24.verticalSpace,
              const LifeChipsList(),
              32.verticalSpace,
              ButtonWidget(
                title: 'Save',
                onTap: () async {
                  final data = UpdateProfileReqDto(
                    interests: selectedIntrestChips
                        .map((e) => e.id)
                        .toList()
                        .toString(),
                    intent: intentCtrl.text,
                  );
                  await ref
                      .read(setupProfileProvider.notifier)
                      .updateProfile(data);
                },
              ),
              45.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LifeChipsList extends StatefulWidget {
  const LifeChipsList({
    super.key,
  });

  @override
  State<LifeChipsList> createState() => _LifeChipsListState();
}

class _LifeChipsListState extends State<LifeChipsList> {
  List<String> availableChips = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        availableChips = ref
            .watch(setupProfileProvider.notifier)
            .hashtags
            .map((e) => e.name ?? '')
            .toList();

        return Wrap(
          children: List.generate(
            availableChips.take(10).length,
            (index) => CustomChip(
              title: availableChips[index],
              selected: selectedHastagChips.contains(availableChips[index]),
              onTap: () {
                if (selectedHastagChips.contains(availableChips[index])) {
                  setState(() {
                    selectedHastagChips.remove(availableChips[index]);
                  });
                  return;
                }
                setState(() {
                  selectedHastagChips.add(availableChips[index]);
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class InterestsChipsList extends StatefulWidget {
  const InterestsChipsList({
    super.key,
  });

  @override
  State<InterestsChipsList> createState() => _InterestsChipsListState();
}

class _InterestsChipsListState extends State<InterestsChipsList> {
  List<Interests> availableChips = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        availableChips = ref.watch(setupProfileProvider.notifier).interests;

        return Wrap(
          children: List.generate(
            availableChips.take(10).length,
            (index) => CustomChip(
              title: availableChips[index].name ?? '',
              selected: selectedIntrestChips.contains(availableChips[index]),
              onTap: () {
                if (selectedIntrestChips.contains(availableChips[index])) {
                  setState(() {
                    selectedIntrestChips.remove(availableChips[index]);
                  });
                  return;
                }
                setState(() {
                  selectedIntrestChips.add(availableChips[index]);
                });

                logger.e(selectedIntrestChips.map((e) => e.name));
                // final data = UpdateProfileReqDto(
                //   interests: selectedChips.map((e) => e.id).toString(),
                // );
                // ref.read(setupProfileProvider.notifier).updateProfile(data);
              },
            ),
          ),
        );
      },
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    this.onTap,
    required this.title,
    this.selected = false,
  });

  final VoidCallback? onTap;
  final String title;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Pallets.primary),
          color: selected ? Pallets.primary : Pallets.white,
        ),
        child: TextView(
          text: "#$title",
          color: selected ? Pallets.white : Pallets.black,
        ),
      ),
    );
  }
}
