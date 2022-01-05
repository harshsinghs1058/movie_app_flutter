import 'package:flutter/material.dart';
import "./../loading.dart";

class PosterPart extends StatelessWidget {
  const PosterPart({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 16),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image(
            image: NetworkImage(
              "https://image.tmdb.org/t/p/original" + posterPath,
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Loading();
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
