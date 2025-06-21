import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/app_colors.dart';
import 'package:quizly_app/core/utils/theme/text_styles.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';

class QuizFitbAnswer extends StatefulWidget {
  const QuizFitbAnswer({super.key, required this.questionId});
  final int? questionId;
  @override
  State<QuizFitbAnswer> createState() => _QuizFitbAnswerState();
}

class _QuizFitbAnswerState extends State<QuizFitbAnswer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizSettingsState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            decoration: InputDecoration(
              hintText: "Answer here",
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.screenWidth * 0.05,
                vertical: context.screenHeight * 0.01,
              ),
              hintStyle: AppTextStyles.bodyMedium,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.onSurfaceDisabled,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.error, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 1),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Value cannot be empty";
              }
              return null;
            },
            onChanged: (value) {
              if (_formKey.currentState!.validate()) {
                SetupSeviceLocator.sl<QuizCubit>().setFITBAnswer(
                  widget.questionId!,
                  controller.text,
                );
              }
            },
          ),
        );
      },
    );
  }
}
