import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_recommendation.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/cubit/event.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/cubit/states.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUseCase getMovieDetailUseCase;
  final GetMovieRecommendationUseCase getMovieRecommendationUseCase;
  MovieDetailBloc(
    this.getMovieDetailUseCase,
      this.getMovieRecommendationUseCase,
  ) : super(const MovieDetailState()) {
    on<GetMovieDetailEvent>(_getMovieDetail);
    on<GetMovieRecommendationEvent>(_getMovieRecommendation);
  }

  FutureOr<void> _getMovieDetail(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    final result =
        await getMovieDetailUseCase(MovieDetailsParameters(movieId: event.id));
    result.fold(
      (l) => emit(
        state.copyWith(
            movieDetailState: RequestStates.error,
            movieDetailMessage: l.message),
      ),
      (r) => emit(
        state.copyWith(
          movieDetail: r,
          movieDetailState: RequestStates.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getMovieRecommendation(GetMovieRecommendationEvent event, Emitter<MovieDetailState> emit) async{
    final result =
    await getMovieRecommendationUseCase(MovieRecommendationParameters(movieId: event.id));
    result.fold(
          (l) => emit(
        state.copyWith(
            recommendationMoviesState: RequestStates.error,
            recommendationMovieMessage: l.message),
      ),
          (r) => emit(
        state.copyWith(
          recommendationMovies: r,
          recommendationMoviesState: RequestStates.loaded,
        ),
      ),
    );
  }
}
