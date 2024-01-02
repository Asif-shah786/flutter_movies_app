import 'package:logger/logger.dart';

import '../../domain/exception/mapper_exception.dart';
import '../../domain/model/movie/movie.dart';
import 'entity/movie_entity.dart';

class NetworkMapper {
  final Logger log;

  NetworkMapper({required this.log});

  Movie toMovie(MovieEntity entity) {
    try {
      return Movie(
        id: entity.id,
        title: entity.titleText.text,
        imageUrl: entity.primaryImage?.url,
        releaseDate: DateTime(
          entity.releaseDate.year,
          entity.releaseDate.month,
          entity.releaseDate.day,
        ),
      );
    } catch (e) {
      throw MapperException<MovieEntity, Movie>(e.toString());
    }
  }

  List<Movie> toMovies(List<MovieEntity> entities) {
    final List<Movie> movies = [];

    for (final entity in entities) {
      try {
        movies.add(toMovie(entity));
      } catch (e) {
        log.w('Could not map entity ${entity.id}', error: e);
      }
    }
    return movies;
  }
}
