import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/modules/movies/domain/entities/movie.dart';
import 'package:movies/modules/movies/domain/entities/movie_detail.dart';
import 'package:movies/modules/movies/domain/entities/recommendation.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_recommendation.dart';

abstract class BaseMovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure,MovieDetail>> getMovieDetail(MovieDetailsParameters movieDetailsParameters);

  Future<Either<Failure,List<MovieRecommendation>>> getMovieRecommendation(MovieRecommendationParameters movieDetailsParameters);

}
