import 'package:movies/modules/movies/domain/entities/recommendation.dart';

class MovieRecommendationModel extends MovieRecommendation {
  const MovieRecommendationModel({
    super.backdropPath,
    required super.id,
  });

  factory MovieRecommendationModel.fromJson(Map<String, dynamic> json) =>
      MovieRecommendationModel(
        id: json["id"],
        backdropPath:
        json["backdrop_path"] ?? '/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
      );
}