import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class UnitCardContent extends StatelessWidget {
  const UnitCardContent({super.key, required this.name, required this.unitId});
  final String name;
  final int unitId;
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
            GoRouter.of(context).push(AppRouter.skillsView, extra: unitId);
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
