import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/service_locator.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/screen/movie_detail_screen.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/cubit.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/events.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/states.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/widgets/widgets.dart';
import 'package:movies/modules/movies/presentation/screens/see_more_screen/see_more_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<MovieBloc>()
          ..add(GetNowPlayingEvent())
          ..add(GetPopularMoviesEvent())
          ..add(GetTopRatedMoviesEvent()),
        child: BlocBuilder<MovieBloc,MoviesState>(
          builder: (context,state) {
            return Scaffold(
              body: SingleChildScrollView(
                key: const Key('movieScrollView'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildGetNowPlayingSlider(),
                    buildPopularAndTopRatedSeeMoreMoviesList(
                        title: 'Popular',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeMoreScreen(
                                  model: state.popularMovies
                              ),
                            ),
                          );
                        }),
                    BlocBuilder<MovieBloc, MoviesState>(
                      buildWhen: (previous, current) =>
                      previous.popularStates != current.popularStates,
                      builder: (context, state) {
                        return FadeIn(
                          duration: const Duration(milliseconds: 500),
                          child: SizedBox(
                            height: 170.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              itemCount: state.popularMovies.length,
                              itemBuilder: (context, index) {
                                return buildPopularAndTopRatedItem(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                            id: state.popularMovies[index].id),
                                      ),
                                    );
                                  },
                                  imageUrl: state.popularMovies[index].backdropPath,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    buildPopularAndTopRatedSeeMoreMoviesList(
                        title: 'Top Rated',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeMoreScreen(
                                  model: state.topRatedMovies
                              ),
                            ),
                          );
                        }),
                    BlocBuilder<MovieBloc, MoviesState>(
                      buildWhen: (previous, current) =>
                      previous.topRatedStates != current.topRatedStates,
                      builder: (context, state) {
                        return FadeIn(
                          duration: const Duration(milliseconds: 500),
                          child: SizedBox(
                            height: 170.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              itemCount: state.topRatedMovies.length,
                              itemBuilder: (context, index) {
                                return buildPopularAndTopRatedItem(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                            id: state.topRatedMovies[index].id),
                                      ),
                                    );
                                  },
                                  imageUrl:
                                  state.topRatedMovies[index].backdropPath,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
