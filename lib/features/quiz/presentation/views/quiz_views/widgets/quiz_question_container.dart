import 'package:flutter/widgets.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';

class QuizQuestionContainer extends StatelessWidget {
  const QuizQuestionContainer({
    super.key,
    this.backgroundColor = AppColors.surface,
    this.fontColor = AppColors.onSurface,
    required this.questionText,
    required this.questionIndex,
  });
  final Color? backgroundColor;
  final Color? fontColor;
  final String questionText;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$questionText = ",
      style: AppTextStyles.heading3.copyWith(color: fontColor!),
    );
  }
}
