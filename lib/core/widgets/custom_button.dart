import 'package:flutter/material.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius,
    required this.text,
    this.fontSize,
    this.borderColor = AppColors.surface,
    this.onPressed,
    this.buttonHeight = 50,
    this.isLoading = false,
  });
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final void Function()? onPressed;
  final double buttonHeight;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
        ),
        child:
            isLoading
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                )
                : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: textColor,
                    fontSize: fontSize,
                  ),
                ),
      ),
    );
  }
}
