import 'package:flutter_movies_app/data/repository/movies_repository.dart';
import 'package:logger/logger.dart';

import '../../domain/model/movie/movie.dart';

class MoviesListModel {
  final Logger log;
  final MoviesRepository moviesRepo;
  const MoviesListModel({required this.log, required this.moviesRepo});

  Future<List<Movie>> fetchPage(int page) async {
    try {
      return await moviesRepo.getUpcomingMovies(page: page, limit: 10);
    } catch (e) {
      log.e('Error when fetching page $page', error: e);
      rethrow;
    }
  }

  Future<void> deletePersistedMovies() async {
    try {
      await moviesRepo.deleteAll();
    } catch (e) {
      log.w('Error when deleting movies', error: e);
      rethrow;
    }
  }

  Future<bool> hasNewData() async {
    try {
      return await moviesRepo.checkNewData();
    } catch (e) {
      log.w('Error when checking for new data', error: e);
      rethrow;
    }
  }
}
