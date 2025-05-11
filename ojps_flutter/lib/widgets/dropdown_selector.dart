import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DropdownSelector extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final void Function(String?)? onChanged;

  const DropdownSelector({
    super.key,
    required this.label,
    required this.options,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          labelStyle: const TextStyle(color: greyColor),
          floatingLabelStyle: TextStyle(color:primaryColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedValue?.isNotEmpty == true ? selectedValue : null,
            items: [
              ...options.map(
                    (value) => DropdownMenuItem(value: value, child: Text(value)),
              ),
            ],
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
