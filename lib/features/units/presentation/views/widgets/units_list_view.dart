import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/constants/media_query_extension.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_cubit.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_state.dart';
import 'package:quizly_app/features/units/presentation/views/widgets/unit_card.dart';

class UnitsListView extends StatelessWidget {
  const UnitsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitsCubit, UnitsState>(
      builder: (context, state) {
        // final cubit = SetupSeviceLocator.sl<UnitsCubit>();
        if (state is FetchUnitsSuccess) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return UnitCard(name: state.units[index]['name']);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: context.screenHeight * 0.02);
            },
            itemCount: state.units.length,
          );
        } else if (state is FetchUnitsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchUnitsError) {
          return Center(child: Text(state.error));
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
