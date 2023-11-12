import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/countries_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';

import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/shared/custom_type_drop_down_search.dart';

class EthnicityTab extends ConsumerStatefulWidget {
  const EthnicityTab(this.controller, {super.key});

  final TabController controller;

  @override
  ConsumerState createState() => _EthnicityTabState();
}

class _EthnicityTabState extends ConsumerState<EthnicityTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController townshipCtrl = TextEditingController();
  TextEditingController otherLanguages = TextEditingController();
  TextEditingController motherTongue = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // Future.delayed(Duration.zero, () {
    prefillFields();
    // });
  }

  @override
  void dispose() {
    otherLanguages.dispose();
    motherTongue.dispose();
    townshipCtrl.dispose();

    super.dispose();
  }

  prefillFields() {
    final userProfile =
        ref.watch(setupProfileProvider.notifier).userProfile.data;
    otherLanguages.text = userProfile?.otherLanguages ?? '';
    townshipCtrl.text = userProfile?.town ?? '';
    // motherTongue.text = userProfile?. ?? '';

    _tribeId = num.tryParse(userProfile?.tribes ?? "0");
    // _tribeId = userProfile?.tribes;
    _residenceCountryId = userProfile?.residenceCountryId?.id;
    _originalCountry = userProfile?.originCountryId?['id'];

    setState(() {});
  }

  num? _tribeId;
  num? _residenceCountryId;
  num? _originalCountry;

  @override
  Widget build(BuildContext context) {
    _listenToProfileStates();

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
            //   text: 'Ethnicity',
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
                CustomTypeDropDownSearch<CountriesData>(
                  hintText: "My family is originally from",
                  hasValidator: true,
                  selectedItem:
                      ref.watch(countryByIdProvider(_originalCountry)),
                  itemAsString: (data) {
                    return data?.name ?? '';
                  },
                  listItems: ref.watch(setupProfileProvider.notifier).countries,
                  onTap: (value) {
                    _originalCountry = value?.id;
                  },
                ),
                16.verticalSpace,
                // CustomTypeDropDownSearch<CountriesData>(
                //   hintText: "Current country of residence",
                //   hasValidator: true,
                //   selectedItem:
                //       ref.watch(countryByIdProvider(_residenceCountryId)),
                //   itemAsString: (CountriesData? data) {
                //     return data?.name ?? '';
                //   },
                //   listItems: ref.watch(setupProfileProvider.notifier).countries,
                //   onTap: (value) {
                //     _residenceCountryId = value?.id;
                //   },
                // ),
                // 16.verticalSpace,
                TextBoxField(
                  label: 'Township/Village name',
                  controller: townshipCtrl,
                ),
                CustomTypeDropDownSearch<Tribes>(
                  hintText: 'Tribe',
                  hasValidator: true,
                  itemAsString: (data) {
                    return data?.name ?? '';
                  },
                  selectedItem: ref.read(tribeByIdProvider(_tribeId)),
                  listItems: ref.watch(setupProfileProvider.notifier).tribes,
                  onTap: (value) {
                    logger.e(value?.id);

                    _tribeId = value?.id;
                    logger.e(_tribeId);
                  },
                ),
                16.verticalSpace,
                TextBoxField(
                  label: 'Mother tongue',
                  controller: motherTongue,
                ),
                // 16.verticalSpace,
                TextBoxField(
                  label: 'Other languages spoken',
                  controller: otherLanguages,
                ),
                45.verticalSpace,
                ButtonWidget(
                  title: 'Save',
                  onTap: () {
                    validateAndExecute(() {
                      final data = UpdateProfileReqDto(
                          otherLanguages: otherLanguages.text,
                          motherTongue: motherTongue.text,
                          tribes: _tribeId.toString(),
                          originCountryId: _originalCountry,
                          residenceCountryId: _residenceCountryId,
                          town: townshipCtrl.text);
                      ref
                          .read(setupProfileProvider.notifier)
                          .updateProfile(data);
                    });
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

  bool get formValidated => (_formKey.currentState?.validate() ?? false);

  void validateAndExecute(VoidCallback action,
      {VoidCallback? validationFailed}) {
    if (formValidated) {
      action();
      // if (dob.text.isNotEmpty && dob.text != "N/A") {
      //   action();
      // } else {
      //   CustomDialogs.error('Enter your date of birth.');
      //   if (validationFailed != null) {
      //     validationFailed();
      //   }
      // }
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

            CustomDialogs.error('Please save your ethnicity information and continue.');
          }
        }, validationFailed: () {
          widget.controller.index = 1;
        });
        setState(() {});
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
