import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import '/models/resume_model.dart';

class ProfileFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final IconData? icon;
  final int maxLines;

  const ProfileFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.enabled = true,
    this.icon,
    this.maxLines = 1,
  }) : super(key: key);

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
      padding: EdgeInsets.symmetric(vertical: dimentions.defaultPadding / 2),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        maxLines: widget.maxLines,
        enabled: widget.enabled,
        cursorColor: Colorss.primaryColor,
        decoration: InputDecoration(
          label: widget.icon != null
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: _focusNode.hasFocus ? Colorss.primaryColor : Colors.grey),
              const SizedBox(width: 4),
              Text(widget.label, style: TextStyle(color: _focusNode.hasFocus ? Colorss.primaryColor : Colors.grey)),
            ],
          )
              : Text(widget.label),
          labelStyle: TextStyle(
            color: _focusNode.hasFocus ? Colorss.primaryColor : Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.primaryColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
        ),
      ),
    );
  }
}
