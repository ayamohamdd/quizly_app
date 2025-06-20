import 'package:quizly_app/features/quiz/domain/entities/mcq_options_entity.dart';

class QuizQuestionEntity {
  int? id;
  int? skillId;
  String? questionText;
  String? level;
  String? type;
  List<McqOptionsEntity>? mcqOptions;
  String? correctAnswer;
  String? explanation;
  QuizQuestionEntity({
    required this.id,
    required this.skillId,
    required this.questionText,
    required this.level,
    required this.type,
    required this.mcqOptions,
    required this.correctAnswer,
    required this.explanation,
  });
}
