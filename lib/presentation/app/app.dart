import 'package:flutter/material.dart';
import 'package:flutter_movies_app/main.dart';
import 'package:flutter_movies_app/presentation/list/movies_list_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key, required this.data});

  final InitialData data;

  @override
  Widget build(BuildContext context) {
    print('APP');
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        title: 'Movies App',
        home: MoviesListScreen(),
      ),
    );
  }
}
