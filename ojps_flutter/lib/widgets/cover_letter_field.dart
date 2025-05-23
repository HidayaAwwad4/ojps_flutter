import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class CoverLetterField extends StatefulWidget {
  const CoverLetterField({super.key});

  @override
  State<CoverLetterField> createState() => _CoverLetterFieldState();
}

class _CoverLetterFieldState extends State<CoverLetterField> {
  final TextEditingController _controller = TextEditingController();
  final int _maxChars = AppValues.coverLetterMaxLength;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: AppValues.animationDurationMs),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.borderRadius),
            gradient: _isFocused
                ? null
                : LinearGradient(
              colors: [
                primaryColor.withOpacity(0.1),
                secondaryTextColor.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: _isFocused ? whiteColor : null,
            border: Border.all(
              color: primaryColor,
              width: AppValues.borderWidth,
            ),
          ),
          child: TextField(
            controller: _controller,
            maxLines: AppValues.coverLetterMaxLines,
            maxLength: _maxChars,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: "Write your Cover Letter...",
              hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.6)),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: _isFocused
                  ? whiteColor
                  : lightBlueBackgroundColor.withOpacity(0.1),
              filled: true,
              counterText: "${_controller.text.length}/$_maxChars",
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
