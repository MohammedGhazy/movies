import 'package:get_it/get_it.dart';
import 'package:movies/modules/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies/modules/movies/data/repositories/movie_repository.dart';
import 'package:movies/modules/movies/domain/repositories/base_movie_repository.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_recommendation.dart';
import 'package:movies/modules/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movies/modules/movies/presentation/screens/detail_screen/cubit/cubit.dart';
import 'package:movies/modules/movies/presentation/screens/movies_screen/cubit/cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {

    /// BLOC
    sl.registerFactory(() => MovieBloc(sl(), sl(), sl()));
    sl.registerFactory(() => MovieDetailBloc(sl() , sl()));

    /// USE CASES
    sl.registerLazySingleton(() => GetNowPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieRecommendationUseCase(sl()));

    /// REPOSITORY
    sl.registerLazySingleton<BaseMovieRepository>(
      () => MovieRepository(sl()),
    );

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
      () => MovieRemoteDataSource(),
    );
  }
}
