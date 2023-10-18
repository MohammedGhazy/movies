import 'package:equatable/equatable.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/modules/movies/data/models/movie_recommendation_model.dart';
import 'package:movies/modules/movies/domain/entities/movie_detail.dart';
import 'package:movies/modules/movies/domain/entities/recommendation.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestStates movieDetailState;
  final String movieDetailMessage;
  final List<MovieRecommendation> recommendationMovies;
  final RequestStates recommendationMoviesState;
  final String recommendationMovieMessage;

  const MovieDetailState({this.movieDetail,
    this.movieDetailState = RequestStates.loading,
    this.movieDetailMessage = "",
    this.recommendationMovieMessage = "",
    this.recommendationMoviesState = RequestStates.loading,
    this.recommendationMovies = const [],
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestStates? movieDetailState,
    String? movieDetailMessage,
    List<MovieRecommendation>? recommendationMovies,
    RequestStates? recommendationMoviesState,
    String? recommendationMovieMessage,

  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieDetailMessage: movieDetailMessage ?? this.movieDetailMessage,
      recommendationMovies: recommendationMovies ?? this.recommendationMovies,
      recommendationMoviesState: recommendationMoviesState ?? this.recommendationMoviesState,
      recommendationMovieMessage: recommendationMovieMessage ?? this.recommendationMovieMessage
    );
  }

  @override
  List<Object?> get props =>
      [
        movieDetail,
        movieDetailMessage,
        movieDetailState,
        recommendationMoviesState,
        recommendationMovies,
        recommendationMovieMessage,
      ];
}
