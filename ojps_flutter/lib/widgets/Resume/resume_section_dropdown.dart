import 'package:flutter/material.dart';
import '/constants/dimensions.dart';
import '/constants/colors.dart';

class ResumeSectionDropdown extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ResumeSectionDropdown({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<ResumeSectionDropdown> createState() => _ResumeSectionDropdownState();
}

class _ResumeSectionDropdownState extends State<ResumeSectionDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: defaultPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colorss.lightGrey),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: widget.children,
              ),
            ),
        ],
      ),
    );
  }
}
