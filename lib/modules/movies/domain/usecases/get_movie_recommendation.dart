import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/modules/movies/domain/entities/recommendation.dart';
import 'package:movies/modules/movies/domain/repositories/base_movie_repository.dart';

class GetMovieRecommendationUseCase extends BaseUseCase<List<MovieRecommendation>,MovieRecommendationParameters> {

  final BaseMovieRepository baseMoviesRepository;

  GetMovieRecommendationUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<MovieRecommendation>>> call(MovieRecommendationParameters parameters) async{
    return await baseMoviesRepository.getMovieRecommendation(parameters);
  }

}

class MovieRecommendationParameters extends Equatable {
  final int movieId;

  const MovieRecommendationParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}