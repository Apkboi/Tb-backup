import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/app/profile/presentation/widgets/upload_photo_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';
import 'package:triberly/core/utils/color_utils.dart';

import '../pages/setup_profile/setup_profile_page.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key, required this.images});

  final List<String?> images;
  @override
  ConsumerState createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController firstName = TextEditingController();
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
    // firstName.dispose();
    //
    // lastName.dispose();
    // email.dispose();
    // gender.dispose();
    // password.dispose();
    // dob.dispose();
    // occupation.dispose();
    // bio.dispose();
    // referral.dispose();
    super.dispose();
  }

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
            text: 'Profile details',
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
              16.verticalSpace,
              TextBoxField(
                label: 'Name',
                topLabel: true,
                controller: firstName,
              ),
              FilterCustomDropDown(
                label: 'Gender',
                hintText: "Gender",
                listItems: const ['Male', 'Female'],
                onTap: (value) {
                  gender.text = value ?? '';
                },
                hasValidator: true,
              ),
              16.verticalSpace,
              CustomPhoneField(
                topLabel: true,
                controller: phoneNumber,
                initialCountryCode: 'NG',
                onChanged: (number) {
                  completeNumber = number.completeNumber;
                  // print(number.completeNumber);
                },
              ),
              TextBoxField(
                topLabel: true,
                label: 'Email Address',
                controller: email,
              ),
              TextBoxField(
                topLabel: true,
                label: 'Date of birth',
                controller: dob,
                hasBottomPadding: false,
              ),
              5.verticalSpace,
              const TextView(
                text: "Your age will be public",
                fontSize: 12,
                color: Pallets.grey,
              ),
              24.verticalSpace,
              TextBoxField(
                topLabel: true,
                label: 'Occupation',
                controller: occupation,
              ),
              TextBoxField(
                label: 'Bio',
                controller: bio,
                minLines: 3,
                maxLines: 4,
                hasBottomPadding: false,
              ),
              5.verticalSpace,
              const TextView(
                text:
                    "At least 160 characters: Don't be shy. Tell us about you.\nWho are you? Your interests, your lifestyle, your beliefs, what you like to do. Or a cool story or what you look forward to. Put your best foot forward.",
                fontSize: 12,
                color: Pallets.grey,
              ),
              24.verticalSpace,
              const TextView(
                text: "Photos",
                fontSize: 16,
                color: Pallets.grey,
                fontWeight: FontWeight.w600,
              ),
              18.verticalSpace,
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0.dg,
                  mainAxisSpacing: 20.0.dg,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final singleItem = widget.images[index];
                  return UploadPhotosWidget(
                    imageUrl: singleItem,
                    delete: () {
                      widget.images[index] = null;
                      setState(() {});
                    },
                    onTap: () async {
                      final imageManger = ImageManager();

                      final imageFile =
                          await imageManger.showPhotoSourceDialog(context);

                      widget.images[index] = imageFile?.path;

                      setState(() {});
                    },
                  );
                },
              ),
              57.verticalSpace,
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
