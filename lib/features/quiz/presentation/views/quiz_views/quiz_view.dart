import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_state.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/quiz_questions_pages.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key, required this.quizId});
  final int quizId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: BlocBuilder<QuizCubit, QuizSettingsState>(
        builder: (context, state) {
          if (state.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          } else if (state.isSuccess == true) {
            return QuizQuestionsPages(
              question: state.questions!,
              quizId: quizId,
            );
          } else if (state.isError == true) {
            return Center(child: Text(state.errorMessage!));
          } else {
            return Center(child: Text("There Is No Questions"));
          }
        },
      ),
    );
  }
}
