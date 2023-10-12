import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/home/presentation/pages/home/home_page.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/app/profile/presentation/widgets/upload_photo_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';
import 'package:triberly/core/utils/color_utils.dart';

class InterestsTab extends ConsumerStatefulWidget {
  const InterestsTab({super.key});

  @override
  ConsumerState createState() => _InterestsTabState();
}

class _InterestsTabState extends ConsumerState<InterestsTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController intentCtrl = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confrimPassword = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String completeNumber = '';

  @override
  void dispose() {
    intentCtrl.dispose();

    lastName.dispose();
    email.dispose();
    gender.dispose();
    password.dispose();
    dob.dispose();
    occupation.dispose();
    bio.dispose();
    referral.dispose();
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
          const TextView(
            text: 'Interests',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          8.verticalSpace,
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
          32.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBoxField(
                label: 'Intent',
                topLabel: true,
                controller: intentCtrl,
              ),
              TextView(
                text: 'The hashtag that fits my life (optional)',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              TextView(
                text: 'Select 3 or more',
                fontSize: 12,
                color: Pallets.grey,
                fontWeight: FontWeight.w600,
              ),
              24.verticalSpace,
              LifeChipsList(),
              32.verticalSpace,
              TextView(
                text: 'Interests',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              TextView(
                text: 'Select 3 or more',
                fontSize: 12,
                color: Pallets.grey,
                fontWeight: FontWeight.w600,
              ),
              24.verticalSpace,
              LifeChipsList(),
              32.verticalSpace,
              ButtonWidget(
                title: 'Save',
                onTap: () {
                  context.pushNamed(PageUrl.setupProfilePage);
                },
                // onTap: (imagesList.contains(null))
                //     ? null
                //     : () {
                //         CustomDialogs.showFlushBar(
                //           context,
                //           'Photos uploaded successfully',
                //         );
                //       },
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
  List<String> selectedChips = [];
  List<String> availableChips = [
    'Exercise',
    'Reading',
    'Cooking',
    'Hiking',
    'Traveling',
    'Yoga',
    'Meditation',
    'Gardening',
    'Painting',
    'Photography',
    'Dancing',
    'Singing',
    'Playing an instrument',
    'Swimming',
    'Cycling',
    'Watching movies',
    'Gaming',
    'Volunteering',
    'Writing',
    'Fishing',
    'Camping',
    'Skiing',
    'Snowboarding',
    'Birdwatching',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        availableChips.length,
        (index) => CustomChip(
          title: availableChips[index],
          selected: selectedChips.contains(availableChips[index]),
          onTap: () {
            if (selectedChips.contains(availableChips[index])) {
              setState(() {
                selectedChips.remove(availableChips[index]);
              });
              return;
            }
            setState(() {
              selectedChips.add(availableChips[index]);
            });
          },
        ),
      ),
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
