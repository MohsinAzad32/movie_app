import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/pages/details.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;
  const MovieScreen({super.key, required this.movie});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          bottom: isExpanded ? 40 : 130,
          child: Container(
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      child: Hero(
                        tag: widget.movie.movieName,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            widget.movie.movieName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildGenres(widget.movie),
                    const SizedBox(
                      height: 5,
                    ),
                    buildRating(widget.movie),
                    const Text(
                      '...',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          bottom: isExpanded ? 150 : 100,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            onDoubleTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(seconds: 1),
                  reverseTransitionDuration: const Duration(seconds: 1),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetailsPage(movie: widget.movie);
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: 'movie_image_${widget.movie.movieName}', // Unique tag
              child: Container(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    widget.movie.imageUrl,
                    fit: BoxFit.cover,
                    height: 400,
                    width: 300,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGenres(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: movie.genres
          .map((genre) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      genre,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget buildRating(Movie movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          movie.rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        ...List.generate(
          movie.stars,
          (index) => const Icon(
            Icons.star_rate,
            color: Colors.orange,
            size: 18,
          ),
        ),
      ],
    );
  }
}
