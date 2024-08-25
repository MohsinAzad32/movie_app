import 'package:flutter/material.dart';
import 'package:movie_app/widgets/background_widget.dart';
// import 'package:movie_app/pages/details.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  bool isExpanded = false;
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

  final controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadmovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          BackgroundWidget(controller: controller),
          PageView.builder(
            itemCount: trendingmovies.length,
            itemBuilder: (context, index) {
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
                                  tag: trendingmovies[index]['title'],
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      trendingmovies[index]['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // buildGenres(widget.movie),
                              const SizedBox(
                                height: 5,
                              ),
                              // buildRating(widget.movie),
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
                      // onDoubleTap: () {
                      //   Navigator.of(context).push(
                      //     PageRouteBuilder(
                      //       transitionDuration: const Duration(seconds: 1),
                      //       reverseTransitionDuration: const Duration(seconds: 1),
                      //       pageBuilder: (context, animation, secondaryAnimation) {
                      //         return DetailsPage(movie: widget.movie);
                      //       },
                      //       transitionsBuilder:
                      //           (context, animation, secondaryAnimation, child) {
                      //         return FadeTransition(
                      //           opacity: animation,
                      //           child: child,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // },
                      child: Hero(
                        tag:
                            'movie_image_${trendingmovies[index]['title']}', // Unique tag
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.network(
                              'http://image.tmdb.org/t/p/w500${trendingmovies[index]["poster_path"]}',
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
            },
          ),
        ],
      ),
    );
  }
}
