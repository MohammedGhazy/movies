import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/service_locator.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/cubit/cubit.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/cubit/event.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/cubit/states.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/widgets/widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailBloc>()
        ..add(GetMovieDetailEvent(id))
        ..add(GetMovieRecommendationEvent(id)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
          switch (state.movieDetailState) {
            case RequestStates.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestStates.loaded:
              return buildDetailInfoItem();
            case RequestStates.error:
              return Center(
                child: Text(state.movieDetailMessage),
              );
          }
        }),
      ),
    );
  }
}
