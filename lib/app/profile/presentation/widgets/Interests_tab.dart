import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/shared/custom_mutiselect_dropdown.dart';

class InterestsTab extends ConsumerStatefulWidget {
  const InterestsTab(this.controller, {super.key});

  final TabController controller;

  @override
  ConsumerState createState() => _InterestsTabState();
}

class _InterestsTabState extends ConsumerState<InterestsTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController intentCtrl = TextEditingController();
  List<Interests> selectedInterestChips = [];
  List<Hashtags> selectedHastagChips = [];
  final intents = const [
    'Love and Romance',
    'Flat mates',
    "New friends",
    "Business partners",
    "Travel buddies"
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    intentCtrl.dispose();

    super.dispose();
  }

  String connectType = '';

  @override
  Widget build(BuildContext context) {
    prefillFields();
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
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
                16.verticalSpace,

                CustomMultiSelectDropdown(
                  options: intents.map((e) => ValueItem(label: e)).toList(),
                  onOptionSelected: (List<ValueItem> options) {
                    logger.e(options.length);
                    if (options.isNotEmpty) {
                      logger.e(options.first.label);
                      intentCtrl.text = options.first.label;
                      setState(() {});
                    }
                  },
                  hint: 'Searching for',
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FilterCustomDropDown(
                //   hintText: "Searching for",
                //   selectedValue: intentCtrl.text,
                //   listItems: const [
                //     'Love and Romance',
                //     'Flat mates',
                //     "New friends",
                //     "Business partners",
                //     "Travel buddies"
                //   ],
                //   onTap: (value) {
                //     intentCtrl.text = value ?? '';
                //   },
                //   hasValidator: true,
                // ),
                16.verticalSpace,
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
                LifeChipsList<Hashtags>(
                  items: ref.watch(setupProfileProvider.notifier).hashtags,
                  onItemSelected: (List<Hashtags> hashtags) {
                    logger.e('message');

                    selectedHastagChips = hashtags;
                    ref.read(selectedHashTagProvider.notifier).state =
                        hashtags as List<Hashtags>;
                    setState(() {});
                  },
                  initialItems: selectedHastagChips,
                ),
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
                LifeChipsList<Interests>(
                  items: ref.watch(setupProfileProvider.notifier).interests,
                  initialItems: selectedInterestChips,
                  onItemSelected: (List<Interests> interests) {
                    selectedInterestChips = interests;
                    ref.read(selectedInterestsProvider.notifier).state =
                        interests;

                    setState(() {});
                  },
                ),
                32.verticalSpace,
                ButtonWidget(
                  title: 'Save',
                  onTap: (ref.watch(selectedInterestsProvider).isNotEmpty &&
                          ref.watch(selectedHashTagProvider).isNotEmpty)
                      ? () async {
                          final data = UpdateProfileReqDto(
                            interests: ref
                                .read(selectedInterestsProvider)
                                .map((e) => e.id)
                                .toList()
                                .join(", "),
                            intent: intentCtrl.text,
                          );
                          await ref
                              .read(setupProfileProvider.notifier)
                              .updateProfile(data);
                        }
                      : null,
                ),
                45.verticalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool get formValidated => (_formKey.currentState?.validate() ?? false);

  void validateAndExecute(VoidCallback action,
      {VoidCallback? validationFailed}) {
    if (formValidated) {
      action();
      if (intentCtrl.text.isNotEmpty) {
        action();
      } else {
        CustomDialogs.error('Select what you are searching for.');
        if (validationFailed != null) {
          validationFailed();
        }
      }
    } else {
      if (validationFailed != null) {
        validationFailed();
      }
    }
  }

  void _listenToProfileStates() {
    ref.listen(setupProfileProvider, (previous, next) {
      if (next is EthnicityValidation) {
        validateAndExecute(() {
          //  Check if fields have been updated
          var user = ref.read(setupProfileProvider.notifier).userProfile.data;

          if (user?.tribes != null &&
              user?.otherLanguages != null &&
              user?.originCountryId != null) {
            widget.controller.index = 2;
          } else {
            widget.controller.index = 1;

            CustomDialogs.error(
                'Please save your ethnicity information and continue.');
          }
        }, validationFailed: () {
          widget.controller.index = 1;
        });
        setState(() {});
      }
    });
  }

  void prefillFields() {
    final userProfile =
        ref.watch(setupProfileProvider.notifier).userProfile.data;

    selectedInterestChips = userProfile?.interests != null
        ? (userProfile!.interests)
            .toString()
            .split(", ")
            .map((e) => ref.watch(interestByIdProvider(int.parse(e)))!)
            .toList()
        : [];
  }
}

class LifeChipsList<T> extends StatefulWidget {
  const LifeChipsList({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.initialItems,
  });

  final List<T> items;
  final Function(List<T>) onItemSelected;
  final List<T> initialItems;

  @override
  _LifeChipsListState<T> createState() => _LifeChipsListState<T>();
}

class _LifeChipsListState<T> extends State<LifeChipsList<T>> {
  List<T> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // availableChips = ref
        //     .watch(setupProfileProvider.notifier)
        //     .hashtags
        //     .map((e) => e.name ?? '')
        //     .toList();

        return Wrap(
          children: List.generate(
            widget.items.length,
            (index) => CustomChip(
              title: widget.items[index].toString(),
              selected: widget.initialItems.contains(widget.items[index]),
              onTap: () {
                if (selectedOptions.contains(widget.items[index])) {
                  setState(() {
                    selectedOptions.remove(widget.items[index]);
                  });
                  widget.onItemSelected(selectedOptions);

                  return;
                }
                setState(() {
                  selectedOptions.add(widget.items[index]);});
                logger.e(selectedOptions.runtimeType);
                widget.onItemSelected(selectedOptions);

                },
            ),
          ),
        );
      },
    );
  }
}

// class InterestsChipsList extends StatefulWidget {
//   const InterestsChipsList({
//     super.key,
//   });
//
//   @override
//   State<InterestsChipsList> createState() => _InterestsChipsListState();
// }
//
// class _InterestsChipsListState extends State<InterestsChipsList> {
//   List<Interests> availableChips = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         availableChips = ref.watch(setupProfileProvider.notifier).interests;
//
//         return Wrap(
//           children: List.generate(
//             availableChips.take(10).length,
//             (index) => CustomChip(
//               title: availableChips[index].name ?? '',
//               selected: selectedIntrestChips.contains(availableChips[index]),
//               onTap: () {
//                 if (selectedIntrestChips.contains(availableChips[index])) {
//                   setState(() {
//                     selectedIntrestChips.remove(availableChips[index]);
//                   });
//                   return;
//                 }
//                 setState(() {
//                   selectedIntrestChips.add(availableChips[index]);
//                 });
//
//                 logger.e(selectedIntrestChips.map((e) => e.name));
//                 // final data = UpdateProfileReqDto(
//                 //   interests: selectedChips.map((e) => e.id).toString(),
//                 // );
//                 // ref.read(setupProfileProvider.notifier).updateProfile(data);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

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
