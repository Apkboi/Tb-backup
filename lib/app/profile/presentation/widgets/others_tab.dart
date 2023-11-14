import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_controller.dart';
import 'package:triberly/core/constants/pallets.dart';
import 'package:triberly/core/navigation/route_url.dart';
import 'package:triberly/core/shared/custom_drop_down.dart';
import 'package:triberly/core/shared/custom_text_button.dart';
import 'package:triberly/core/shared/text_box.dart';
import 'package:triberly/core/shared/text_view.dart';

class OthersTab extends ConsumerStatefulWidget {
  const OthersTab(this.controller, {Key? key}) : super(key: key);
  final TabController controller;


  @override
  ConsumerState<OthersTab> createState() => _OthersTabState();
}

class _OthersTabState extends ConsumerState<OthersTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController education = TextEditingController();
  TextEditingController faith = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController relationShip = TextEditingController();
  TextEditingController otherLanguage = TextEditingController();
  TextEditingController haveKids = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Future.delayed(Duration.zero, () {
      _prefillTab();
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            21.verticalSpace,
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
                TextBoxField(
                  label: 'School or University (optional)',
                  controller: education,
                  hasBottomPadding: false,
                ),
                8.verticalSpace,
                FilterCustomDropDown(
                  hintText: "Faith/Religion",
                  selectedValue: faith.text,
                  listItems: const ['Christianity', 'Islam',"Buddhism","Hinduism"],
                  onTap: (value) {
                    faith.text = value ?? '';
                  },
                  hasValidator: true,
                ),
                FilterCustomDropDown(
                  hintText: "Relationship Status",
                  selectedValue: relationShip.text,
                  listItems: const ['Single', 'In a Relationship',"Engaged","Married"],
                  onTap: (value) {
                    relationShip.text = value ?? '';
                  },
                  hasValidator: true,
                ),
                FilterCustomDropDown(
                  label: null,
                  hintText: "Other languages spoken",
                  selectedValue: otherLanguage.text,
                  listItems: const ['English', 'French'],
                  onTap: (value) {
                    otherLanguage.text = value ?? '';
                  },
                  hasValidator: true,
                ),
                FilterCustomDropDown(
                  hintText: "Do you have kids?",
                  selectedValue: haveKids.text,
                  listItems: const ['Yes', 'No'],
                  onTap: (value) {
                    haveKids.text = value ?? '';
                  },
                  hasValidator: true,
                ),
                57.verticalSpace,
                ButtonWidget(
                  title: 'Save',
                  onTap: () {

                    if(formValidated){
                      final data = UpdateProfileReqDto(
                          education: education.text,
                          otherLanguages: otherLanguage.text,
                          haveKids: haveKids.text,
                          relationShipStatus: relationShip.text
                      );
                      ref.read(setupProfileProvider.notifier)
                          .updateProfile(data)
                          .then(
                            (value) => context.goNamed(PageUrl.home),
                      );
                    }



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

  _prefillTab() {
    final userProfile =
        ref.watch(setupProfileProvider.notifier).userProfile.data;

    haveKids.text = userProfile?.haveKids ?? '';
    faith.text = userProfile?.religion ?? '';
    // gender.text = userProfile?.religion ?? '';
    otherLanguage.text = userProfile?.otherLanguages ?? '';
    relationShip.text = userProfile?.relationshipStatus ?? '';
    education.text = userProfile?.education ?? '';

    setState(() {});
  }

  bool get formValidated => (_formKey.currentState?.validate() ?? false);




  @override
  bool get wantKeepAlive => true;
}
