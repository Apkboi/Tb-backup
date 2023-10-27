import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../_core.dart';

class CustomTypeDropDownSearch<T> extends StatefulWidget {
  const CustomTypeDropDownSearch({
    super.key,
    this.hintText,
    this.label,
    this.selectedItem,
    required this.listItems,
    required this.onTap,
    this.dropDownKey,
    this.hasValidator = false,
    required this.itemAsString,
  });

  final String? hintText;
  final String? label;
  final List<T> listItems;
  final T? selectedItem;
  final void Function(T?) onTap;
  final String Function(T?) itemAsString;
  final GlobalKey<FormFieldState>? dropDownKey;
  final bool hasValidator;

  @override
  State<CustomTypeDropDownSearch<T>> createState() =>
      _CustomTypeDropDownSearchState<T>();
}

class _CustomTypeDropDownSearchState<T>
    extends State<CustomTypeDropDownSearch<T>> {
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
        DropdownSearch<T>(
          itemAsString: widget.itemAsString,
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
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
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
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            showSearchBox: true,
            // showSelectedItems: true,
          ),
          items: widget.listItems,
          selectedItem: widget.selectedItem,
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Pallets.borderGrey,
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
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          onChanged: (value) {
            if (value != null) {
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
