import 'package:flutter/material.dart';
import 'package:movie_app_flutter/components/movie_details/clips.dart';
import 'package:movie_app_flutter/components/movie_details/overview.dart';
import 'package:movie_app_flutter/components/movie_details/poster.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails(this.movie, {Key? key}) : super(key: key);
  final Map movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("AZ-Movies"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              PosterPart(
                posterPath: movie["poster_path"],
              ),
              const SizedBox(height: 5),
              Text(
                movie["title"],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "⭐ " + movie["vote_average"].toString() + "/10",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  text: "Release date: ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: movie["release_date"],
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: ClipsPart(
                  movieId: movie["id"].toString(),
                ),
              ),
              const SizedBox(height: 5),
              OverView(
                overview: movie["overview"],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
