  import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';

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
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.verticalSpacerSmall),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.primaryColor, width: 2),
          ),
          labelStyle: const TextStyle(color: Colorss.greyColor),
          floatingLabelStyle: TextStyle(color: Colorss.primaryColor),
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
