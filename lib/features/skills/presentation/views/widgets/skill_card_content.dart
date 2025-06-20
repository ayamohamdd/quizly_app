import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class SkillCardContent extends StatelessWidget {
  const SkillCardContent({
    super.key,
    required this.name,
    required this.skillId,
  });
  final String name;
  final int skillId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(
              context,
            ).push(AppRouter.skillPerformanceView, extra: skillId);
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
