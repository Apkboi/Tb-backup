import 'package:flutter/material.dart';
import 'package:triberly/app/profile/presentation/widgets/profile_option_item.dart';
import 'package:triberly/core/_core.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Security'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            ProfileOptionItem(
                leaadingImage: Assets.svgsShield,
                tittle: "Suspend/delete my account",
                onTap: () {
                  context.pushNamed(
                    PageUrl.suspendAccount,
                  );
                },
                hasArrow: true),
            ProfileOptionItem(
                leaadingImage: Assets.svgsSlash,
                tittle: "Manage blocked users",
                onTap: () {},
                hasArrow: true),
            ProfileOptionItem(
                leaadingImage: Assets.svgsLock,
                tittle: "Change password",
                onTap: () {
                  context.pushNamed(
                    PageUrl.changePassword,
                  );
                },
                hasArrow: true),
          ],
        ),
      )),
    );
  }
}
