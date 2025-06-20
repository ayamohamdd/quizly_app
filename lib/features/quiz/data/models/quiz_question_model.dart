import 'package:quizly_app/features/quiz/domain/entities/mcq_options_entity.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';

class QuizQuestionModel extends QuizQuestionEntity {
  @override
  int? id;
  @override
  int? skillId;
  @override
  String? questionText;
  @override
  String? level;
  @override
  String? type;
  @override
  List<McqOptionsEntity>? mcqOptions;
  @override
  String? correctAnswer;
  @override
  String? explanation;
  QuizQuestionModel({
    required this.id,
    required this.skillId,
    required this.questionText,
    required this.level,
    required this.type,
    required this.correctAnswer,
    required this.explanation,
    required this.mcqOptions
  }) : super(
         id: id,
         skillId: skillId,
         questionText: questionText,
         level: level,
         type: type,
         correctAnswer: correctAnswer,
         explanation: explanation,
         mcqOptions: mcqOptions
       );

  factory QuizQuestionModel.fromDatabase(Map<String, dynamic> db) {
    return QuizQuestionModel(
      id: db['id'],
      skillId: db['skill_id'],
      questionText: db["question_text"],
      level: db["level"],
      type: db["type"],
      correctAnswer: db["correct_answer"],
      explanation: db["explanation"],
      mcqOptions: null
    );
  }
}
