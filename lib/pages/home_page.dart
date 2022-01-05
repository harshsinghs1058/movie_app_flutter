import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:movie_app_flutter/components/loading.dart';
import "dart:convert";
import 'package:movie_app_flutter/pages/movie_details.dart';
import './../components/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? data;
  Future<void> fetchData() async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/day?api_key=c07163fa942193e6498300ba6afc2692"));
    setState(() {
      var jsonData = jsonDecode(res.body);
      data = jsonData["results"];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (data.toString() == "null") {
      return const Loading();
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("AZ-Movies"),
          ),
          backgroundColor: Colors.grey[700],
          body: ListView.builder(
              itemCount: data?.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (BuildContext context, int i) {
                return MovieCard(data?[i]);
              }),
        ),
      );
    }
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard(this.movie, {Key? key}) : super(key: key);
  final Map movie;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(movie),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage(
                    "https://image.tmdb.org/t/p/original" +
                        movie["poster_path"],
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                movie["title"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              "⭐ " + movie["vote_average"].toString() + "/10",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
