import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repository/movies_repository.dart';
import 'package:flutter_movies_app/domain/model/movie/movie.dart';
import 'package:flutter_movies_app/presentation/list/movie_preview.dart';
import 'package:flutter_movies_app/presentation/list/movies_list_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  late final MoviesListModel _model;
  late final Future _future;

  @override
  void initState() {
    _model = MoviesListModel(
      log: Provider.of<Logger>(context, listen: false),
      moviesRepo: Provider.of<MoviesRepository>(context, listen: false),
    );

    _future = _checkNewData();

    _pagingController.addPageRequestListener((pageKey) async {
      try {
        final movies = await _model.fetchPage(pageKey);
        _pagingController.appendPage(movies, pageKey + 1);
      } catch (e) {
        _pagingController.error = e;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: PagedListView<int, Movie>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Movie>(
                itemBuilder: (context, movie, index) => Container(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 6.0,
                    right: 12.0,
                    bottom: 6.0,
                  ),
                  child: MoviePreview(
                    movie: movie,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _refresh() async {
    await _model.deletePersistedMovies();
    _pagingController.refresh();
  }

  Future<void> _checkNewData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final hasNewData = await _model.hasNewData();
      if (hasNewData) {
        scaffoldMessenger.showSnackBar(SnackBar(
          content: const Text('Refresh to obtain the new available data'),
          action: SnackBarAction(
            label: 'Refresh',
            onPressed: _refresh,
          ),
        ));
      }
    });
  }
}
