import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import "./../loading.dart";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class ClipsPart extends StatefulWidget {
  const ClipsPart({required this.movieId, Key? key}) : super(key: key);
  final String movieId;
  @override
  _ClipsPartState createState() => _ClipsPartState();
}

class _ClipsPartState extends State<ClipsPart> {
  List? clips;

  Future<void> fetchClips() async {
    var res = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/" +
        widget.movieId +
        "/videos?api_key=c07163fa942193e6498300ba6afc2692"));

    setState(() {
      var jsonData = jsonDecode(res.body);
      clips = jsonData["results"];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchClips();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Clips",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10),
        (clips == null)
            ? const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: clips?.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ClipsTile(clip: clips?[i]);
                  },
                ),
              ),
      ],
    );
  }
}

class ClipsTile extends StatelessWidget {
  const ClipsTile({Key? key, required this.clip}) : super(key: key);
  final Map clip;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch(
        "https://youtube.com/watch?v=" + clip["key"],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage("https://img.youtube.com/vi/" +
                              clip["key"] +
                              "/hqdefault.jpg"),
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
                    const Center(
                      child: Icon(
                        Icons.play_circle_filled_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              clip["name"],
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
