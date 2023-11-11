import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:triberly/core/_core.dart';

class CustomMultiSelectDropdown extends StatelessWidget {
  const CustomMultiSelectDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      showClearIcon: true,
      // controller: _controller,
      onOptionSelected: (options) {
        debugPrint(options.toString());
      },
      options: const <ValueItem>[
        ValueItem(label: 'Option 1', value: '1'),
        ValueItem(label: 'Option 2', value: '2'),
        ValueItem(label: 'Option 3', value: '3'),
        ValueItem(label: 'Option 4', value: '4'),
        ValueItem(label: 'Option 5', value: '5'),
        ValueItem(label: 'Option 6', value: '6'),
      ],
      maxItems: 2,
      disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: 200,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
      borderColor: Pallets.grey,
      borderWidth: 0.5,
      focusedBorderColor: Pallets.grey,
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),


      // color: hasValue ? Pallets.primary : Pallets.borderGrey),
      borderRadius: 8,

    );
  }
}
