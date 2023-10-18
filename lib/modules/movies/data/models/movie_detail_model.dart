import 'dart:math';

import 'package:movies/modules/movies/data/models/genres_model.dart';
import 'package:movies/modules/movies/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.backdropPath,
    required super.genres,
    required super.id,
    required super.overview,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
    required super.runtime,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        backdropPath: json["backdrop_path"],
        genres: List<GenresModel>.from(
            json["genres"].map((e) => GenresModel.fromJson(e))),
        id: json["id"],
        overview: json["overview"],
        releaseDate: json["release_date"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        runtime: json["runtime"],
      );
}
