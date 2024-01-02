import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repository/movies_repository.dart';
import 'package:flutter_movies_app/domain/model/movie/movie.dart';
import 'package:provider/provider.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  Widget build(BuildContext context) {
    final moviesRepo = Provider.of<MoviesRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: moviesRepo.getUpcomingMovies(limit: 10, page: 1),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print("Error : ${snapshot.error}");
          }
          if (snapshot.hasData) {
            return ListView(
              children: List.generate(
                snapshot.data!.length,
                (index) => ListTile(
                  title: Text(snapshot.data![index].title ?? ''), // Null check for title),
              ),),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
