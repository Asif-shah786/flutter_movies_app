import "package:json_annotation/json_annotation.dart";

part "movie_entity.g.dart";

@JsonSerializable()
class UpcomingMovies {
  List<MovieEntity> results;

  UpcomingMovies({
    required this.results,
  });

  factory UpcomingMovies.fromJson(Map<String, Object?> json) =>
      _$UpcomingMoviesFromJson(json);
}

@JsonSerializable()
class MovieEntity {
  String id;
  PrimaryImage? primaryImage;
  TitleText titleText;
  ReleaseYear releaseYear;
  ReleaseDate releaseDate;

  MovieEntity({
    required this.id,
    required this.primaryImage,
    required this.titleText,
    required this.releaseYear,
    required this.releaseDate,
  });

  factory MovieEntity.fromJson(Map<String, Object?> json) =>
      _$MovieEntityFromJson(json);
}

@JsonSerializable()
class TitleText {
  String text;

  TitleText({
    required this.text,
  });

  factory TitleText.fromJson(Map<String, Object?> json) =>
      _$TitleTextFromJson(json);
}

@JsonSerializable()
class PrimaryImage {
  String id;
  int width;
  int height;
  String url;
  Caption caption;

  PrimaryImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.caption,
  });

  factory PrimaryImage.fromJson(Map<String, Object?> json) =>
      _$PrimaryImageFromJson(json);
}

@JsonSerializable()
class Caption {
  String plainText;

  Caption({
    required this.plainText,
  });

  factory Caption.fromJson(Map<String, Object?> json) =>
      _$CaptionFromJson(json);
}

@JsonSerializable()
class ReleaseDate {
  int day;
  int month;
  int year;

  ReleaseDate({
    required this.day,
    required this.month,
    required this.year,
  });

  factory ReleaseDate.fromJson(Map<String, Object?> json) =>
      _$ReleaseDateFromJson(json);
}

@JsonSerializable()
class ReleaseYear {
  int year;
  dynamic endYear;

  ReleaseYear({
    required this.year,
    required this.endYear,
  });
  factory ReleaseYear.fromJson(Map<String, Object?> json) =>
      _$ReleaseYearFromJson(json);
}
