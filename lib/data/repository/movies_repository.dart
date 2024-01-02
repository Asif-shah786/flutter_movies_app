import 'package:flutter_movies_app/data/network/client/api_client.dart';
import 'package:flutter_movies_app/data/network/network_mapper.dart';
import 'package:flutter_movies_app/domain/model/movie/movie.dart';

import '../database/dao/movies_dao.dart';
import '../database/database_mapper.dart';

class MoviesRepository {
  final NetworkMapper networkMapper;
  final ApiClient apiClient;
  final DatabaseMapper databaseMapper;
  final MoviesDao moviesDao;

  MoviesRepository({
    required this.apiClient,
    required this.networkMapper,
    required this.moviesDao,
    required this.databaseMapper,
  });

  Future<List<Movie>> getUpcomingMovies({
    required int page,
    required int limit,
  }) async {
    //Try to load movies from the database

    final dbEntities =
        await moviesDao.selectAll(limit: limit, offset: (page * limit) - limit);

    if (dbEntities.isNotEmpty) {
      return databaseMapper.toMovies(dbEntities);
    }

    //Fetch movies from the remote API
    final upcomingMovies =
        await apiClient.getUpcomingMovies(page: page, limit: limit);
    final movies = networkMapper.toMovies(upcomingMovies.results);

    //called insertAll without await because i don't want to wait for inserting
    moviesDao.insertAll(databaseMapper.toMoviesDbEntities(movies));

    return movies;
  }

  Future<void> deleteAll() async => await moviesDao.deleteAll();

  Future<bool> checkNewData() async {
    final entities = await moviesDao.selectAll(limit: 1);

    if (entities.isEmpty) {
      return false;
    }

    final entity = entities.first;
    final movies = await apiClient.getUpcomingMovies(page: 1, limit: 1);

    if (entity.movieId == movies.results.first.id) {
      return false;
    } else {
      return true;
    }
  }
}
