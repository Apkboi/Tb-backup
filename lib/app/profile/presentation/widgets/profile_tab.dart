import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/countries_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_other_photos_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/app/profile/presentation/widgets/upload_photo_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';
import 'package:triberly/core/shared/custom_type_drop_down_search.dart';


class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

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
  List<String?> otherImages = [];
  num? _residenceCountryId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    dob = TextEditingController();
    occupation = TextEditingController();
    bio = TextEditingController();
    gender = TextEditingController();
    password = TextEditingController();
    confrimPassword = TextEditingController();
    referral = TextEditingController();
    phoneNumber = TextEditingController();
    otherImages = [null, null, null, null];
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Future.delayed(Duration.zero, () {
      _prefillTab();
    });
  }

  _prefillTab() {
    final userProfile =
        ref.watch(setupProfileProvider.notifier).userProfile.data;

    firstName.text = userProfile?.firstName ?? '';
    lastName.text = userProfile?.lastName ?? '';
    email.text = userProfile?.email ?? '';
    dob.text = userProfile?.dob ?? '';
    occupation.text = userProfile?.profession ?? '';
    bio.text = userProfile?.bio ?? '';
    gender.text = userProfile?.gender ?? '';
    referral.text = userProfile?.refCode ?? '';
    _residenceCountryId = userProfile?.residenceCountryId?.id;
    phoneNumber.text = userProfile?.phoneNo?.replacePlus234() ?? '';
    otherImages = List.generate(userProfile?.otherImages?.length ?? 0,
        (index) => userProfile!.otherImages?[index].url);

    setState(() {
      gender.text = userProfile?.gender ?? '';
    });
  }

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

    //
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          21.verticalSpace,
          // const TextView(
          //   text: 'Profile details',
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
              16.verticalSpace,
              TextBoxField(
                label: 'Name',
                topLabel: true,
                controller: firstName,
              ),

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
                itemCount: otherImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0.dg,
                  mainAxisSpacing: 20.0.dg,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final singleItem = otherImages[index];
                  return UploadPhotosWidget(
                    imageUrl: singleItem,
                    delete: () async {
                      try {
                        // await CloudinaryManager.deleteFile(otherImages[index]!);
                        otherImages[index] = null;
                      } catch (e) {
                        logger.e(e);
                      }
                      setState(() {});
                    },
                    onTap: () async {
                      final imageManger = ImageManager();

                      final imageFile =
                      await imageManger.showPhotoSourceDialog(context);

                      otherImages[index] = imageFile?.path;
                      setState(() {});

                      ///Upload to cloud and Update image url
                      Future.delayed(Duration.zero, () async {
                        CustomDialogs.showLoading(context);

                        try {
                          if (otherImages[index] != null) {
                            await CloudinaryManager.uploadFile(
                              filePath: imageFile?.path ?? '',
                              file: File(otherImages[index] ?? ''),
                            ).then((value) {
                              otherImages[index] = value;

                              if (!(otherImages.contains(null))) {
                                ref
                                    .read(setupProfileProvider.notifier)
                                    .uploadOtherPhotos(
                                  UpdateOtherPhotosReqDto(
                                    images: List.generate(
                                      otherImages.length,
                                          (index) => otherImages[index]!,
                                    ),
                                  ),
                                );
                              }
                            });
                          }
                        } catch (e) {
                          logger.e(e.toString());
                        } finally {
                          CustomDialogs.hideLoading(context);
                        }
                      });
                    },
                  );
                },
              ),
              FilterCustomDropDown(
                label: 'Gender',
                hintText: "Gender",
                selectedValue: gender.text,
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
                  gender.text = "Female";
                  completeNumber = number.completeNumber;
                  // print(number.completeNumber);
                },
              ),
              TextBoxField(
                topLabel: true,
                label: 'Email Address',
                controller: email,
              ),
              InkWell(
                onTap: () async {
               _pickDate(context);
                },
                child: TextBoxField(
                  topLabel: true,
                  isEnabled: false,
                  label: 'Date of birth',
                  controller: dob,
                  hasBottomPadding: false,
                ),
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

              CustomTypeDropDownSearch<CountriesData>(
                hintText: "Current country of residence",
                hasValidator: true,
                selectedItem:
                ref.watch(countryByIdProvider(_residenceCountryId)),
                itemAsString: (CountriesData? data) {
                  return data?.name ?? '';
                },
                listItems: ref.watch(setupProfileProvider.notifier).countries,
                onTap: (value) {
                  _residenceCountryId = value?.id;
                },
              ),
              16.verticalSpace,
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

              57.verticalSpace,
              ButtonWidget(
                title: 'Save',
                onTap: (otherImages.contains(null))
                    ? null
                    : () {
                        final data = UpdateProfileReqDto(
                          firstName: firstName.text,
                          lastName: lastName.text,
                          profession: occupation.text,
                          bio: bio.text,
                          dob: dob.text,
                          phone: phoneNumber.text,
                        );
                        ref
                            .read(setupProfileProvider.notifier)
                            .updateProfile(data);
                        // CustomDialogs.showFlushBar(
                        //   context,
                        //   'Profile updated successfully',
                        // );
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

  void _pickDate(BuildContext context) async {
  pickDate(context, DateTime.now());


  // }
    // final value = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime(3000),
    // );
    //
    // if (value != null) {
    //   dob.text = TimeUtil.formatDateDDMMYYY(
    //       value.toIso8601String() ?? '');
    // }
  }


  Future<void> pickDate(BuildContext context, DateTime initialDate) async {

    DateTime? pickedDate = await CustomDialogs.selectDate(initialDate, context);

    if (pickedDate != null) {
      dob.text = TimeUtil.formatDateDDMMYYY(
          pickedDate.toIso8601String() ?? '');
    }
  }

}









