import 'package:dio/dio.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/network/api_constants.dart';
import 'package:movies/core/network/error_message_model.dart';
import 'package:movies/modules/movies/data/models/movie_detail_model.dart';
import 'package:movies/modules/movies/data/models/movie_model.dart';
import 'package:movies/modules/movies/data/models/movie_recommendation_model.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies/modules/movies/domain/usecases/get_movie_recommendation.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailModel> getMovieDetail(
      MovieDetailsParameters movieDetailsParameters);

  Future<List<MovieRecommendationModel>> getMovieRecommendation(
      MovieRecommendationParameters parameters);
}

class MovieRemoteDataSource implements BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstant.nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data["results"] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstant.popularMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data["results"] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstant.topRatedMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data["results"] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(
      MovieDetailsParameters movieDetailsParameters) async {
    final response = await Dio()
        .get(ApiConstant.movieDetailsPath(movieDetailsParameters.movieId));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieRecommendationModel>> getMovieRecommendation(
      MovieRecommendationParameters parameters) async {
    final response =
        await Dio().get(ApiConstant.recommendationPath(parameters.movieId));
    if (response.statusCode == 200) {
       return List<MovieRecommendationModel>.from(
          (response.data["results"] as List).map(
                (e) => MovieRecommendationModel.fromJson(e),
          ));
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
