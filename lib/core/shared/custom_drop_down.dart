import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../_core.dart';

class FilterCustomDropDown<T> extends StatefulWidget {
  String? selectedValue;
  String? hintText;
  String? label;
  List<String> listItems;
  void Function(String?) onTap;
  final BoxDecoration? decoration;
  final GlobalKey<FormFieldState>? dropDownKey;

  final double? buttonHeight;
  final double? dropDownWidth;
  final bool hasValidator;

  FilterCustomDropDown({
    Key? key,
    this.hintText,
    this.label,
    this.selectedValue,
    required this.listItems,
    required this.onTap,
    this.decoration,
    this.dropDownKey,
    this.buttonHeight,
    this.dropDownWidth,
    this.hasValidator = false,
  }) : super(key: key);

  @override
  State<FilterCustomDropDown> createState() =>
      _FilterCustomDropDownState(selectedValue);
}

class _FilterCustomDropDownState extends State<FilterCustomDropDown> {
  _FilterCustomDropDownState(this.selectedValue);

  String? selectedValue;
  bool hasValue = false;

  @override
  void didUpdateWidget(covariant FilterCustomDropDown oldWidget) {
    if (selectedValue != widget.selectedValue) {
      setState(() {
        selectedValue = widget.selectedValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          TextView(
            text: widget.label ?? '',
            fontSize: 14,
            color: Pallets.primaryDark,
          ),
        if (widget.label != null) 0.verticalSpace,
        DropdownButtonFormField2(
          key: widget.dropDownKey,
          decoration: const InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,

              // borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            contentPadding: EdgeInsets.only(
              bottom: 16,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
          ),
          isExpanded: true,
          hint: TextView(
            text: widget.hintText ?? '',
            textOverflow: TextOverflow.ellipsis,
          ),
          iconStyleData: IconStyleData(
            icon: widget.decoration != null
                ? const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.transparent,
                    size: 30,
                  )
                : const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Pallets.primary,
                    size: 30,
                  ),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
          ),
          buttonStyleData: ButtonStyleData(
            height: widget.buttonHeight ?? 55,
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            decoration: widget.decoration ??
                BoxDecoration(
                  border: Border.all(color: Pallets.borderGrey),
                  // color: hasValue ? Pallets.primary : Pallets.borderGrey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: widget.dropDownWidth,
              padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              elevation: 3,
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              )),
          items: widget.listItems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            // color:,
                            fontSize: 16.sp,
                            // color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ))
              .toList(),
          value: widget.selectedValue,
          validator: (value) {
            if (value == null && widget.hasValidator) {
              return 'Please select an option.';
            }
            return null;
          },
          onChanged: (value) {
            if (value != null && value.isNotEmpty) {
              hasValue = true;
            } else {
              hasValue = false;
            }
            setState(() {});
            super.widget.onTap(value);
          },
          onSaved: (value) {
            // if (widget.decoration == null) {
            //   setState(() {
            widget.selectedValue = value.toString();
            // });
            // }
          },
          selectedItemBuilder: widget.decoration == null
              ? null
              : (context) {
                  return widget.listItems.map(
                    (item) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: const Text(
                          '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Pallets.primary,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      );
                    },
                  ).toList();
                },
        ),
      ],
    );
  }
}
