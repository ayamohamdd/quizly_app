import 'package:flutter/material.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/features/skills/presentation/views/widgets/skills_list_view.dart';
import 'package:quizly_app/features/units/presentation/views/widgets/units_list_view.dart';

class SkillsView extends StatelessWidget {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Math Units")),
      body: Padding(
        padding: EdgeInsets.only(
          top: context.screenHeight * 0.03,
          right: context.screenWidth * 0.03,
          left: context.screenWidth * 0.03,
        ),
        child:SkillsListView()
      ),
    );
  }
}
