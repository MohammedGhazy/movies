import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/modules/movies/domain/entities/movie_detail.dart';
import 'package:movies/modules/movies/domain/repositories/base_movie_repository.dart';

class GetMovieDetailUseCase extends BaseUseCase<MovieDetail , MovieDetailsParameters >{

  final BaseMovieRepository baseMovieDetailRepository;

  GetMovieDetailUseCase(this.baseMovieDetailRepository);

  @override
  Future<Either<Failure, MovieDetail>> call(MovieDetailsParameters parameters) async{
    return await baseMovieDetailRepository.getMovieDetail(parameters);
  }

}

class MovieDetailsParameters extends Equatable {
  final int movieId;

  const MovieDetailsParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}