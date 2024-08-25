import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/movies.dart';
import 'package:movie_app/widgets/background_widget.dart';
import 'package:movie_app/widgets/movie_widget.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();

  List trendingmovies = [];
  final String apikey = '9e4323c5e0b5fd412621e5ae9c3ac0f4';
  final String apireadtoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZTQzMjNjNWUwYjVmZDQxMjYyMWU1YWU5YzNhYzBmNCIsIm5iZiI6MTcyNDMyMjE2Mi41MjQwMiwic3ViIjoiNjZjNmU1NWM4ZmVkN2NjZDc0YzNiMDVjIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.sQx05ogQcGgpMDqzMSwwC1llEXhtHa-Djwx0xt_6igY';

  Future loadmovies() async {
    TMDB tmdb = TMDB(
      ApiKeys(
        apikey,
        apireadtoken,
      ),
    );
    final trending = await tmdb.v3.trending.getTrending();
    setState(() {
      trendingmovies = trending['results'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadmovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(controller: controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider(
              items: trendingmovies
                  .map(
                    (e) => MovieScreen(
                      movie: e,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 0.75,
                height: MediaQuery.of(context).size.height * 0.8,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  controller.animateToPage(index,
                      duration: const Duration(seconds: 1), curve: Curves.ease);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
