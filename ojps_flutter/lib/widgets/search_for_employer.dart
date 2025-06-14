import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const SearchWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: tr('Search_jobs'),
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.searchBorderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.searchBorderRadius),
          borderSide: BorderSide(color: Colorss.greyColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.searchBorderRadius),
          borderSide: BorderSide(color: Colorss.primaryColor, width: 2),
        ),
      ),

    );
  }
}
