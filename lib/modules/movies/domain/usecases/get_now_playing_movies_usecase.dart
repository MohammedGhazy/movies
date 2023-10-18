import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/modules/movies/domain/entities/movie.dart';
import 'package:movies/modules/movies/domain/repositories/base_movie_repository.dart';

class GetNowPlayingUseCase extends BaseUseCase<List<Movie> , NoParameters> {
  final BaseMovieRepository baseMovieRepository;
  GetNowPlayingUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async{
    return await baseMovieRepository.getNowPlayingMovies();
  }


}