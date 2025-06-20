import 'package:quizly_app/features/quiz/domain/entities/mcq_options_entity.dart';

class McqOptionsModel extends McqOptionsEntity {
  @override
  int? id;
  @override
  int? questionId;
  @override
  String? optionText;
  @override
  int? isCorrect;
  McqOptionsModel({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCorrect,
  }) : super(
         id: id,
         questionId: questionId,
         optionText: optionText,
         isCorrect: isCorrect,
       );

  factory McqOptionsModel.fromDatabase(Map<String, dynamic> db) {
    return McqOptionsModel(
      id: db["id"] as int?,
      questionId: db["question_id"] as int?,
      optionText: db["option_text"] as String?,
      isCorrect: db["is_correct"] as int?,
    );
  }
}
