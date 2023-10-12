import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/app/profile/presentation/widgets/upload_photo_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';
import 'package:triberly/core/utils/color_utils.dart';

class EthnicityTab extends ConsumerStatefulWidget {
  const EthnicityTab({super.key});

  @override
  ConsumerState createState() => _EthnicityTabState();
}

class _EthnicityTabState extends ConsumerState<EthnicityTab>
    with AutomaticKeepAliveClientMixin {
  TextEditingController townshipCtrl = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tribeCtrl = TextEditingController();
  TextEditingController otherLanguages = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confrimPassword = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String completeNumber = '';

  @override
  void dispose() {
    townshipCtrl.dispose();

    lastName.dispose();
    email.dispose();
    gender.dispose();
    password.dispose();
    tribeCtrl.dispose();
    otherLanguages.dispose();
    bio.dispose();
    referral.dispose();
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
            text: 'Ethnicity',
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
              FilterCustomDropDown(
                hintText: "My family is originally from",
                listItems: const [],
                onTap: (value) {},
                hasValidator: true,
              ),
              16.verticalSpace,
              FilterCustomDropDown(
                hintText: "Current country of residence",
                listItems: const [],
                onTap: (value) {},
                hasValidator: true,
              ),
              16.verticalSpace,
              TextBoxField(
                label: 'Township/Village name',
                controller: townshipCtrl,
              ),
              TextBoxField(
                label: 'Tribe',
                controller: tribeCtrl,
              ),
              FilterCustomDropDown(
                hintText: 'Mother tongue',
                listItems: const [],
                onTap: (value) {},
                hasValidator: true,
              ),
              16.verticalSpace,
              TextBoxField(
                label: 'Other languages spoken',
                controller: otherLanguages,
              ),
              45.verticalSpace,
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
