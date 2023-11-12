import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:triberly/core/_core.dart';

class CustomMultiSelectDropdown extends StatelessWidget {
  const CustomMultiSelectDropdown(
      {Key? key,
      required this.options,
      required this.onOptionSelected,
      this.controller,
      required this.hint})
      : super(key: key);
  final List<ValueItem> options;
  final Function(List<ValueItem>) onOptionSelected;
  final MultiSelectController? controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      showClearIcon: true,
      controller: controller,
      onOptionSelected: (options) {
        onOptionSelected(options);
        debugPrint(options.toString());
      },
      options: options,
      hint: hint,

      hintColor: Pallets.grey,
      // maxItems: 2,
      // disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: 200,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
      borderColor: Pallets.grey,
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 30,
      ),
      borderWidth: 0.5,

      focusedBorderColor: Pallets.grey,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      // color: hasValue ? Pallets.primary : Pallets.borderGrey),
      borderRadius: 8,
    );
  }
}
