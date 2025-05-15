import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';

class ProfileFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;

  const ProfileFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.enabled = true,
  });

  @override
  State<ProfileFieldWidget> createState() => _ProfileFieldWidgetState();
}

class _ProfileFieldWidgetState extends State<ProfileFieldWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        enabled: widget.enabled,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          label: widget.label == "Location"
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 18, color: _focusNode.hasFocus ? primaryColor : Colors.grey),
              const SizedBox(width: 4),
              Text(widget.label, style: TextStyle(color: _focusNode.hasFocus ? primaryColor : Colors.grey)),
            ],
          )
              : Text(widget.label),
          labelStyle: TextStyle(
            color: _focusNode.hasFocus ? primaryColor : Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
        ),
      ),
    );
  }
}
