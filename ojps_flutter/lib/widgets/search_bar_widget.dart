import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search jobs",
        hintStyle: TextStyle(
          color: secondaryTextColor.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}
