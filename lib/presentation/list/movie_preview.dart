import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/movie/movie.dart';

class MoviePreview extends StatelessWidget {
  const MoviePreview({super.key, required this.movie});

  static const _size = 100.0;

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMd();
    return Card(
      child: Row(
        children: [
          if (movie.imageUrl != null)
            Container(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                right: 16,
                bottom: 8,
              ),
              child: SizedBox(
                width: _size,
                height: _size,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: movie.imageUrl!,
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                right: 16,
                bottom: 8,
              ),
              child: const _PlaceholderImage(
                size: _size,
              ),
            ),
          Flexible(
              child: Container(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              right: 16,
              bottom: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(formatter.format(movie.releaseDate),
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage({super.key, required this.size});

  final double size;
  @override
  Widget build(BuildContext context) => Icon(
        Icons.image_not_supported,
        size: size,
        color: Colors.black38,
      );
}
