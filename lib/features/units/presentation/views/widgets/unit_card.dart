import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/features/units/presentation/views/widgets/unit_card_content.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight * 0.09,
      decoration: BoxDecoration(
        color: AppColors.onTertiary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.04),
        child: UnitCardContent(name: name),
      ),
    );
  }
}
