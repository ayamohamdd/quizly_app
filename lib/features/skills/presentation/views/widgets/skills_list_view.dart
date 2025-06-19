import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/features/skills/presentation/manager/cubit/skills_cubit.dart';
import 'package:quizly_app/features/skills/presentation/manager/cubit/skills_state.dart';
import 'package:quizly_app/features/skills/presentation/views/widgets/skill_card.dart';

class SkillsListView extends StatelessWidget {
  const SkillsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillsCubit, SkillsState>(
      builder: (context, state) {
        if (state is FetchSkillsSuccess) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return SkillCard(name: state.skills[index].name!);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: context.screenHeight * 0.02);
            },
            itemCount: state.skills.length,
          );
        } else if (state is FetchSkillsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchSkillsError) {
          return Center(child: Text(state.error));
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
