import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search jobs",
        hintStyle: TextStyle(
          color: Colorss.secondaryTextColor.withOpacity(AppValues.searchBarHintTextOpacity),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colorss.primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppValues.searchBarBorderRadius),
          borderSide: BorderSide(color: Colorss.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppValues.searchBarBorderRadius),
          borderSide: BorderSide(
            color: Colorss.primaryColor,
            width: AppValues.searchBarFocusedBorderWidth,
          ),
        ),
      ),
    );
  }
}
