import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({super.key});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;
  bool _isSubmitted = false;

  void _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: AppValues.submitDelaySeconds));

    setState(() {
      _isLoading = false;
      _isSubmitted = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Submitted successfully!"),
        backgroundColor: Colorss.successColor,
      ),
    );

    await Future.delayed(Duration(seconds: AppValues.submitSuccessDelaySeconds));
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: AppValues.animationDurationMs),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading || _isSubmitted ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isSubmitted ? Colorss.successColor : Colorss.primaryColor,
          foregroundColor: Colorss.whiteColor,
          elevation: 4,
          shadowColor: Colorss.primaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(
              vertical: AppValues.verticalButtonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.borderRadiusButton),
          ),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: AppValues.animationDurationMs),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: _isLoading
              ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: Colorss.whiteColor,
              strokeWidth: 2.5,
            ),
          )
              : _isSubmitted
              ? const Icon(Icons.check,
              size: AppValues.submitIconSize, color: Colorss.whiteColor)
              : const Text(
            "Submit",
            style: TextStyle(
              fontSize: AppValues.buttonFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
