import 'package:flutter/material.dart';
import 'package:movie_app/movie_model.dart';
import 'package:html/parser.dart' show parse;

class MovieDetails extends StatefulWidget {
  final Welcome movie;
  const MovieDetails({super.key, required this.movie});
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    String textWithoutHtmlTags =
        parse(widget.movie.show.summary.toString()).body?.text ?? '';
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:
            const Text("Movie Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.movie.show.image == null
                ? const Icon(Icons.movie, size: 50)
                : Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.movie.show.image!.original,
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                widget.movie.show.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              widget.movie.show.genres.join(', ').toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    const Text('Rating: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text(
                      widget.movie.show.rating.average.toString() == 'null'
                          ? 'unrated'
                          : widget.movie.show.rating.average.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    const Text('Runtime: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Text(
                      widget.movie.show.runtime.toString() == 'null'
                          ? 'N/A'
                          : '${widget.movie.show.runtime.toString()} min',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text('Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Text(
                textWithoutHtmlTags,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
