import 'package:flutter_movies_app/data/network/client/api_client.dart';
import 'package:flutter_movies_app/data/network/network_mapper.dart';
import 'package:flutter_movies_app/domain/model/movie/movie.dart';

class MoviesRepository{

  final NetworkMapper networkMapper;
  final ApiClient apiClient;

  MoviesRepository({required this.apiClient, required this.networkMapper});

  Future<List<Movie>> getUpcomingMovies({
    required int page,
    required int limit,
}) async {
    final upcomingMovies = await apiClient.getUpcomingMovies(page: page, limit: limit);
    return networkMapper.toMovies(upcomingMovies.results);
  }
}