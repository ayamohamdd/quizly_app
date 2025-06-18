import 'package:flutter/material.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class UnitCardContent extends StatelessWidget {
  const UnitCardContent({super.key, required this.name});
  final String name;
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
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
      ],
    );
  }
}
