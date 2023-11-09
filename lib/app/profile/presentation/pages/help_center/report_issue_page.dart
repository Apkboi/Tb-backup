import 'package:flutter/material.dart';
import 'package:triberly/app/profile/presentation/widgets/selecteable_container.dart';
import 'package:triberly/core/_core.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  State<ReportIssuePage> createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  List<SelectionModel> issues = [
    SelectionModel(index: 1, title: "Payment/subscription issues?"),
    SelectionModel(index: 2, title: "Account hacked or unauthorized access?"),

    SelectionModel(index: 4, title: "Others"),
    // Add more reasons as needed
  ];

  int selectedIssueId = 0;

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Report an issue",
        trailing: TextButton(
            onPressed: () {},
            child: const Text(
              'History',
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            16.verticalSpace,
            const TextView(
              text:
                  "Report issues you’re facing using the app. Our customer care will quickly attend to your complaint",
              style: TextStyle(fontSize: 14, color: Pallets.grey),
            ),
            24.verticalSpace,
            ...issues.map((reason) {
              final isSelected = reason.index == selectedIssueId;
              return SelectableContainer(
                reason: reason,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedIssueId =
                        isSelected ? 0 : reason.index; // Toggle selection
                  });
                },
              );
            }).toList(),
            20.verticalSpace,
            TextBoxField(
              controller: descriptionController,
              hintText: "Give more details...",
              label: 'Description',
              maxLines: 5,
              textAlign: TextAlign.start,
            ),
            50.verticalSpace,
            ButtonWidget(
              title: 'Submit',
              onTap: () {},
            ),
            50.verticalSpace,
          ],
        ),
      )),
    );
  }
}
