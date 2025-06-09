import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '/constants/dimensions.dart';

class ResumeFieldDropdownWidget extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ResumeFieldDropdownWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<ResumeFieldDropdownWidget> createState() => _ResumeFieldDropdownWidgetState();
}

class _ResumeFieldDropdownWidgetState extends State<ResumeFieldDropdownWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.defaultPadding),
      decoration: BoxDecoration(
        color: Colorss.whiteColor,
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        border: Border.all(color: Colorss.primaryColor),
      ),
      child: ExpansionTile(
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        childrenPadding: EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() => isExpanded = expanded);
        },
        children: widget.children,
      ),
    );
  }
}
