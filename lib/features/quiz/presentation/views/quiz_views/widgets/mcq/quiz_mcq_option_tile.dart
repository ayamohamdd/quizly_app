import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class McqOptionTile extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const McqOptionTile({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  Color getBorderColor() {
    if (isSelected && isDisabled) return AppColors.error;
    if (isSelected) return AppColors.primary;
    return AppColors.onSurfaceDisabled;
  }

  Color getFillColor() {
    if (!isSelected) return Colors.transparent;
    return isDisabled ? AppColors.error : AppColors.primary;
  }

  Color getTextColor() {
    if (isSelected && isDisabled) return AppColors.error;
    if (isSelected) return AppColors.primary;
    return AppColors.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.screenHeight * 0.01),
        padding: EdgeInsets.symmetric(
          vertical: context.screenHeight * 0.015,
          horizontal: context.screenWidth * 0.06,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: getBorderColor(), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: getBorderColor(), width: 2),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: getFillColor(),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
            SizedBox(width: context.screenWidth * 0.04),
            Expanded(
              child: Text(
                optionText,
                style: AppTextStyles.bodyMedium.copyWith(color: getTextColor()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
