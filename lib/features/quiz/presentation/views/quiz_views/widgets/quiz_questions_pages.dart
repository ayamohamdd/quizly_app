import 'package:flutter/widgets.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/fitb/quiz_fitb_question_builder.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/widgets/mcq/quiz_mcq_question_builder.dart';

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
        physics:NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: widget.question.length,
        itemBuilder: (context, index) {
          if (widget.question[index].type == 'mcq') {
            return QuizMcqAnswerBuilder(
              pageController: pageController,
              questionEntity: widget.question[index],
              questionIndex: index,
              questionsLength: widget.question.length,
            );
          } else {
            return QuizFitbAnswerBuilder(
              pageController: pageController,
              questionEntity: widget.question[index],
              questionIndex: index,
              questionsLength: widget.question.length,
            );
          }
        },
      ),
    );
  }
}
