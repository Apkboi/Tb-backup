import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/shared/custom_mutiselect_dropdown.dart';
import 'package:triberly/core/utils/interest_image_mapper.dart';

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

  var intentsController = MultiSelectController();

  @override
  void dispose() {
    intentCtrl.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      prefillFields();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration.zero, () {
      prefillFields();
    });
  }

  String connectType = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _listenToProfileStates();
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
                FilterCustomDropDown(
                  hintText: "Who are you looking to connect to ?",
                  selectedValue: connectType,
                  listItems: const ['Men Only', 'Women Only', "Anyone"],
                  onTap: (value) {
                    connectType = value ?? '';
                  },
                  hasValidator: false,
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
                  controller: intentsController,
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
                    selectedHastagChips = hashtags;
                    setState(() {});
                  },
                  initialItems: selectedHastagChips, hasImage: false,
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
                    setState(() {});
                  }, hasImage: true,
                ),
                32.verticalSpace,
                ButtonWidget(
                  title: 'Save',
                  onTap: (selectedInterestChips.isNotEmpty)
                      ? () async {
                          validateAndExecute(
                            () async {
                              final data = UpdateProfileReqDto(
                                interests: selectedInterestChips
                                    .map((e) => e.id)
                                    .toList()
                                    .join(", "),
                                intent: intentCtrl.text,
                              );
                              await ref
                                  .read(setupProfileProvider.notifier)
                                  .updateProfile(data);
                            },
                            validationFailed: () {
                              widget.controller.index = 2;
                            },
                          );
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
      {required VoidCallback validationFailed}) {
    if (formValidated) {
      if (intentCtrl.text.isNotEmpty) {
        if (selectedInterestChips.isEmpty) {
          CustomDialogs.error('Select your interests.');
          validationFailed();
        } else {
          action();
        }
      } else {
        validationFailed();
        CustomDialogs.error('Select what you are searching for.');
      }
    } else {
      validationFailed();
    }
  }

  void _listenToProfileStates() {
    ref.listen(setupProfileProvider, (previous, next) {
      if (next is InterestValidation) {
        validateAndExecute(() {
          //  Check if fields have been updated
          var user = ref.read(setupProfileProvider.notifier).userProfile.data;

          if (user?.intent != null && user?.interests != null) {
            widget.controller.index = next.nextIndex;
          } else {
            widget.controller.index = 2;
            CustomDialogs.error(
                'Please save your interests information and continue.');
          }
        }, validationFailed: () {
          widget.controller.index = 2;
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

    // interest as List<Interests>;
    logger.e("USERS INTERESTS${selectedInterestChips.length}");
    if (userProfile?.intent != null) {
      intentsController
          .setSelectedOptions([ValueItem(label: userProfile?.intent)]);
    }
    setState(() {});
  }
}

class LifeChipsList<T> extends StatelessWidget {
  const LifeChipsList({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.initialItems,
    required this.hasImage,
  });

  final List<T> items;
  final Function(List<T>) onItemSelected;
  final List<T> initialItems;
 final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        items.length,
        (index) => CustomChip(
          hasImage: hasImage,
          title: items[index].toString(),
          selected: initialItems
              .map((e) => e.toString())
              .contains(items[index].toString()),
          onTap: () {
            logger
                .e("SELECTED CONTAINS: ${initialItems.contains(items[index])}");
            logger.e("SELECTED OPTIONS${initialItems.length}");

            if (initialItems
                .map((e) => e.toString())
                .contains(items[index].toString())) {
              initialItems.removeWhere(
                  (element) => element.toString() == items[index].toString());
              onItemSelected(initialItems);
              return;
            } else {
              initialItems.add(items[index]);
              logger.e(initialItems.runtimeType);
              onItemSelected(initialItems);
            }
          },
        ),
      ),
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
    this.hasImage = false,
  });

  final VoidCallback? onTap;
  final String title;
  final bool? hasImage;

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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            if (hasImage!)
              ImageWidget(
                imageUrl: InterestsHelper.getInterestAssetByName(title),
                size: 15,
                imageType: ImageWidgetType.asset,
                color: selected ? Pallets.white : Pallets.primary,
              ),
            5.horizontalSpace,

            TextView(
              text: hasImage!?title:"#$title",
              color: selected ? Pallets.white : Pallets.black,
            ),
          ],
        ),
      ),
    );
  }
}
