import 'package:dartz/dartz.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/modules/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies/modules/movies/domain/entities/movie.dart';
import 'package:movies/modules/movies/domain/entities/movie_detail.dart';
import 'package:movies/modules/movies/domain/entities/recommendation.dart';
import 'package:movies/modules/movies/domain/repositories/base_movie_repository.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_recommendation.dart';

class MovieRepository extends BaseMovieRepository {

  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MovieRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure , List<Movie>>> getNowPlayingMovies() async{
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    }on ServerExceptions catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async{
    final result = await baseMovieRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    }on ServerExceptions catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async{
    final result = await baseMovieRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    }on ServerExceptions catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(MovieDetailsParameters movieDetailsParameters) async{
    final result = await baseMovieRemoteDataSource.getMovieDetail(movieDetailsParameters);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<MovieRecommendation>>> getMovieRecommendation(MovieRecommendationParameters parameters) async{
    final result = await baseMovieRemoteDataSource.getMovieRecommendation(parameters);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}