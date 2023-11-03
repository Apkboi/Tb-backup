import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Security"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextView(
              text: "Change your password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            16.verticalSpace,
            TextBoxField(
              label: 'Password',
              controller: password,
              isPasswordField: true,
            ),
            TextBoxField(
              label: 'Confirm Password',
              controller: confirmPassword,
              isPasswordField: true,
            ),
            25.verticalSpace,
            ButtonWidget(
              title: 'Confirm',
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
