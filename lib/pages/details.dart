import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;
  const DetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                tag: 'movie_image_${movie.movieName}', // Same unique tag
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Image.asset(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: movie.movieName,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  movie.movieName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          buildGenres(movie),
          const SizedBox(height: 5),
          buildRating(movie),
          const SizedBox(height: 8),
          Card(
            color: Colors.blueGrey.shade800,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.description,
                style: TextStyle(
                    color: Colors.grey.shade200, fontFamily: 'Times New Roman'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  'Cast',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ),
          ),
          Card(
              color: Colors.blueGrey.shade800,
              child: Column(
                children: movie.cast
                    .map((c) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(c.imageUrl),
                          ),
                          title: Text(
                            c.name,
                            style:
                                const TextStyle(fontFamily: 'Times New Roman'),
                          ),
                        ))
                    .toList(),
              )),
        ],
      ),
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
                      color: Colors.grey.shade400,
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      genre,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Times New Roman',
                        color: Colors.grey.shade400,
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
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey.shade400),
        ),
        const SizedBox(width: 5),
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
