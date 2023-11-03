import 'package:flutter/material.dart';
import 'package:triberly/app/profile/presentation/widgets/profile_option_item.dart';
import 'package:triberly/core/_core.dart';
class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Help center'),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                ProfileOptionItem(
                    leaadingImage: Assets.svgsCall,
                    tittle: "Report an issue",
                    onTap: () {
                      context.pushNamed(PageUrl.reportIssue);
                    },
                    hasArrow: true),
                ProfileOptionItem(
                    leaadingImage: Assets.svgsMessageQuestion,
                    tittle: "Frequently asked questions (FAQS)",
                    onTap: () {},
                    hasArrow: true),

              ],
            ),
          )),
    );
  }
}
