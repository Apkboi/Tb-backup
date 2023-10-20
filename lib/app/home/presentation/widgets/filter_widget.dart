import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

import '_home_widgets.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    super.key,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String connectType = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .94.sh,
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.pop(),
                  child: Container(
                    width: 30.dg,
                    height: 30.dg,
                    decoration: BoxDecoration(
                      color: Pallets.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.xmark,
                      size: 14,
                    ),
                  ),
                ),
                TextView(
                  text: 'Filters',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                TextView(
                  text: 'Clear',
                  fontSize: 12,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w400,
                  onTap: () {},
                ),
              ],
            ),
            33.verticalSpace,
            TextView(
              text: 'Age',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            16.verticalSpace,
            CustomRangeSlider(),
            32.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Current location',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Original country',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Tribe',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Languages',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Faith',
              listItems: [],
              onTap: (value) {},
            ),
            24.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'Looking to connect with',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                18.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConnectTypeRadio(
                      title: 'Men Only',
                      value: connectType,
                      onTap: () {
                        connectType = 'Men Only';
                        setState(() {});
                      },
                    ),
                    ConnectTypeRadio(
                      title: 'Women Only',
                      value: connectType,
                      onTap: () {
                        connectType = 'Women Only';
                        setState(() {});
                      },
                    ),
                    ConnectTypeRadio(
                      title: 'Anyone',
                      value: connectType,
                      onTap: () {
                        connectType = 'Anyone';
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
            24.verticalSpace,
            CustomDropDownSearch(
              hintText: 'Intent',
              listItems: [],
              onTap: (value) {},
            ),
            37.verticalSpace,
            ButtonWidget(
              title: 'Done',
              onTap: () {
                context.pop();
              },
            ),
            100.verticalSpace,
          ],
        ),
      ),
    );
  }
}
