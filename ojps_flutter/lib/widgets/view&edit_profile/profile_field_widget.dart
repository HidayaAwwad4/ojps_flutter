import 'package:flutter/material.dart';
import '../../constants/spaces.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import '/models/resume_model.dart';

class ProfileFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final IconData? icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const ProfileFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.enabled = true,
    this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator
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
      padding: EdgeInsets.symmetric(vertical: AppDimensions.defaultPadding / 2),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        maxLines: widget.maxLines,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        cursorColor: Colorss.primaryColor,
        decoration: InputDecoration(
          label: widget.icon != null
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: _focusNode.hasFocus ? Colorss.primaryColor : Colors.grey),
              Spaces.horizontal(4),
              Text(widget.label, style: TextStyle(color: _focusNode.hasFocus ? Colorss.primaryColor : Colors.grey)),
            ],
          )
              : Text(widget.label),
          labelStyle: TextStyle(
            color: _focusNode.hasFocus ? Colorss.primaryColor : Colorss.lightGrey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.primaryColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.lightGrey, width: 1.5),
          ),
        ),
        validator: widget.validator
      ),
    );
  }
}
