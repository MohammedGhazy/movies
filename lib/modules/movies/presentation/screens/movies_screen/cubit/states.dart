import 'package:equatable/equatable.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/modules/movies/domain/entities/movie.dart';

class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final RequestStates nowPlayingStates;
  final RequestStates popularStates;
  final RequestStates topRatedStates;
  final String nowPlayingMessage;
  final String popularMessage;
  final String topRatedMessage;

  const MoviesState({
    this.nowPlayingMovies   = const [],
    this.popularMovies      = const [],
    this.topRatedMovies     = const [],
    this.nowPlayingStates   = RequestStates.loading,
    this.popularStates      = RequestStates.loading,
    this.topRatedStates     = RequestStates.loading,
    this.nowPlayingMessage  = "",
    this.popularMessage     = "",
    this.topRatedMessage    = "",
  });

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestStates? nowPlayingStates,
    String? nowPlayingMessage,
    List<Movie>? popularMovies,
    RequestStates? popularStates,
    String? popularMessage,
    List<Movie>? topRatedMovies,
    RequestStates? topRatedStates,
    String? topRatedMessage,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingStates: nowPlayingStates ?? this.nowPlayingStates,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      popularStates: popularStates ?? this.popularStates,
      popularMessage: popularMessage ?? this.popularMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedStates: topRatedStates ?? this.topRatedStates,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    nowPlayingMovies,
    popularMovies,
    topRatedMovies,
    nowPlayingStates,
    popularStates,
    topRatedStates,
    nowPlayingMessage,
    popularMessage,
    topRatedMessage,
  ];


}
