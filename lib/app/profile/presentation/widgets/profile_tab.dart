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
import 'package:triberly/core/utils/string_extension.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab(this.controller, {super.key});

  final TabController controller;

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final userProfile = ref.watch(setupProfileProvider.notifier).userProfile.data;
    firstName.text = userProfile?.firstName ?? '';
    lastName.text = userProfile?.lastName ?? '';
    email.text = userProfile?.email ?? '';
    dob.text = userProfile?.dob != null
        ? TimeUtil.formatDateDDMMYYY(userProfile?.dob ?? '')
        : '';
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

    _listenToProfileStates();

    //
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            21.verticalSpace,

            const TextView(
              text:
                  'Add a bit more to enable us match with other Trybers with similar background.',
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
validator: FieldValidators.notEmptyValidator,               ),
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
                  validator: FieldValidators.emailValidator,
                  // validator: FieldValidators.,
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
                    validator: FieldValidators.notEmptyValidator,
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
                  validator: FieldValidators.notEmptyValidator,
                ),
                CustomTypeDropDownSearch<CountriesData>(
                  hintText: "Current country of residence",
                  hasValidator: true,
                  selectedItem: ref.watch(countryByIdProvider(_residenceCountryId)),
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
                  validator: FieldValidators.notEmptyValidator,
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
                          _updateProfile(context);

                        },
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

  void _pickDate(BuildContext context) async {
    pickDate(context, DateTime.now());

  }

  Future<void> pickDate(BuildContext context, DateTime initialDate) async {
    DateTime? pickedDate = await CustomDialogs.selectDate(initialDate, context);

    if (pickedDate != null) {
      dob.text = TimeUtil.formatDateDDMMYYY(pickedDate.toIso8601String() ?? '');
    }
  }

  void _updateProfile(BuildContext context) {
    validateAndExecute(() {
      final data = UpdateProfileReqDto(
        firstName: firstName.text,
        lastName: lastName.text,
        profession: occupation.text,
        bio: bio.text,
        dob: dob.text,
        phone: phoneNumber.text,
        residenceCountryId: _residenceCountryId,
      );
      ref.read(setupProfileProvider.notifier).updateProfile(data);
    });
  }

  bool get formValidated => (_formKey.currentState?.validate() ?? false);

  void validateAndExecute(VoidCallback action,
      {VoidCallback? validationFailed}) {
    if (formValidated) {
      if (dob.text.isNotEmpty && dob.text != "N/A") {
        action();
      } else {
        if (validationFailed != null) {
          validationFailed();
        }
        CustomDialogs.error('Enter your date of birth.');
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
      if (next is PersonalBioValidation) {
        validateAndExecute(() {

          //  Check if fields have been updated
          var user = ref.read(setupProfileProvider.notifier).userProfile.data;
          if (user?.profession != null &&
              user?.bio != null &&
              user?.residenceCountryId != null) {
            widget.controller.index = next.nextIndex;
          }else{
            widget.controller.index = 0;
            CustomDialogs.error('Please save your personal bio and continue.');
          }
        }, validationFailed: () {
          widget.controller.index = 0;
        });
        setState(() {});
      }
    });
  }
}
