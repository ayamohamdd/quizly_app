import 'package:flutter/widgets.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/quiz_answer_builder.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/mcq/quiz_mcq_options.dart';

class QuizQuestionsPages extends StatefulWidget {
  const QuizQuestionsPages({super.key, required this.question});
  final List<QuizQuestionEntity> question;

  @override
  State<QuizQuestionsPages> createState() => _QuizQuestionsPagesState();
}

class _QuizQuestionsPagesState extends State<QuizQuestionsPages> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.05,
        vertical: context.screenHeight * 0.03,
      ),
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.question.length,
        itemBuilder: (context, index) {
          return QuizAnswerBuilder(
            pageController: pageController,
            answer:
                widget.question[index].type == 'mcq'
                    ? QuizMcqOptions(
                      questionIndex: widget.question[index].id!,
                      questionOptions: widget.question[index].mcqOptions!,
                    )
                    : Center(),
            questionText: widget.question[index].questionText!,
            questionIndex: index,
            questionsLength: widget.question.length,
          );
        },
      ),
    );
  }
}
