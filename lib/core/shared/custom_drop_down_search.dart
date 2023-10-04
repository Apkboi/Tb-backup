import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../_core.dart';

class CustomDropDownSearch extends StatefulWidget {
  const CustomDropDownSearch({
    super.key,
    this.hintText,
    this.label,
    required this.listItems,
    required this.onTap,
    this.dropDownKey,
    this.hasValidator = false,
  });

  final String? hintText;
  final String? label;
  final List<String> listItems;
  final void Function(String?) onTap;
  final GlobalKey<FormFieldState>? dropDownKey;

  final bool hasValidator;

  @override
  State<CustomDropDownSearch> createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch> {
  bool hasBeenChanged = false;

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
        if (widget.label != null) 10.verticalSpace,
        DropdownSearch<String>(
          popupProps: const PopupProps.menu(
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),

                errorMaxLines: 1,

                hintStyle: TextStyle(
                  color: Pallets.borderGrey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                // errorStyle: TextStyle(fontSize: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    // color: Pallets.primary,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Pallets.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),

                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Pallets.borderGrey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    // color: isEmpty.value ? Pallets.borderGrey : Pallets.primary,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                // disabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide.none,
                // ),
              ),
            ),
            showSearchBox: true,
            showSelectedItems: true,
          ),
          items: widget.listItems,
          validator: (value) {
            if (value == null && widget.hasValidator) {
              return 'Please select an option.';
            }
            return null;
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,

              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),

              errorMaxLines: 1,

              hintText: widget.hintText ?? '',
              hintStyle: TextStyle(
                color: Pallets.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              // errorStyle: TextStyle(fontSize: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Pallets.borderGrey,

                  // color: Pallets.primary,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Pallets.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Pallets.borderGrey),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Pallets.borderGrey,
                  // color: isEmpty.value ? Pallets.borderGrey : Pallets.primary,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              // disabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide.none,
              // ),
            ),
          ),
          onChanged: (value) {
            if (value != null && value.isNotEmpty) {
              setState(() {
                hasBeenChanged = true;
              });
            }

            widget.onTap(value);
          },
        ),
      ],
    );
  }
}
