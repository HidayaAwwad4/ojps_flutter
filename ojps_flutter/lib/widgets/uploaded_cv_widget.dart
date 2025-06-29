import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class UploadedCvWidget extends StatefulWidget {
  const UploadedCvWidget({super.key});

  @override
  State<UploadedCvWidget> createState() => _UploadedCvWidgetState();
}

class _UploadedCvWidgetState extends State<UploadedCvWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppValues.animationDurationMs),
    );
    _scaleAnimation = Tween<double>(
      begin: AppValues.scaleBegin,
      end: AppValues.scaleEnd,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {},
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(AppValues.defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(color: Colorss.primaryColor),
            borderRadius: BorderRadius.circular(AppValues.borderRadius),
            color: Colorss.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colorss.primaryColor.withOpacity(AppValues.boxShadowOpacity),
                blurRadius: AppValues.boxShadowBlur,
                offset: Offset(0, AppValues.boxShadowOffsetY),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colorss.primaryColor.withOpacity(AppValues.gradientOpacity),
                Colorss.secondaryTextColor.withOpacity(AppValues.gradientOpacity),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "cv_razan.pdf",
                style: TextStyle(
                  fontSize: AppValues.uploadedCvFontSize,
                  fontWeight: FontWeight.w500,
                  color: Colorss.primaryColor,
                ),
              ),
              Icon(
                Icons.edit,
                color: Colorss.primaryColor,
                size: AppValues.editIconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

