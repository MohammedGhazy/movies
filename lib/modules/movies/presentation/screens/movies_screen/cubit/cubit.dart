import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/modules/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/events.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/states.dart';

class MovieBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MovieBloc(
    this.getNowPlayingUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    on<GetNowPlayingEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  Future<void> _getNowPlayingMovies(GetNowPlayingEvent event , Emitter<MoviesState> emit) async{
    final result = await getNowPlayingUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
              nowPlayingStates: RequestStates.error,
              nowPlayingMessage: l.message
            ),),
            (r) => emit(state.copyWith(
              nowPlayingMovies: r,
              nowPlayingStates: RequestStates.loaded,
            ))
    );
  }

  Future<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          popularStates: RequestStates.error,
          popularMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          popularMovies: r,
          popularStates: RequestStates.loaded,
        ),
      ),
    );
  }

  Future<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(state.copyWith(
        topRatedMessage: l.message,
        topRatedStates: RequestStates.error,
      )),
      (r) => emit(
        state.copyWith(
          topRatedMovies: r,
          topRatedStates: RequestStates.loaded,
        ),
      ),
    );
  }
}
