import 'package:flutter/material.dart';
import 'package:movie_app/data/movies.dart';

class BackgroundWidget extends StatefulWidget {
  final PageController controller;
  const BackgroundWidget({super.key, required this.controller});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  final allmovies = movies;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemCount: allmovies.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                allmovies[index].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.0001),
                    Colors.white,
                  ],
                  stops: const [
                    0.5,
                    0.75,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
