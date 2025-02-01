import 'package:clean_architecture/features/presentation/widgets/poster_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/globals.dart';
import '../../../core/utils/utils.dart';
import '../../domain/entities/movie.dart';
import '../bloc/movie_block.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie>? popularMovie;
  List<Movie>? topRated;
  List<Movie>? upcoming;

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  getMovieList() {
    BlocProvider.of<MovieBloc>(context).add(GetMovies(type: "popular"));
    BlocProvider.of<MovieBloc>(context).add(GetMovies(type: "top_rated"));
    BlocProvider.of<MovieBloc>(context).add(GetMovies(type: "upcoming"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Color(0XFF032541),
          title: Text(
            "TMDB",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 25),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    "Theme",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: widget.toggleTheme,
                      child: Icon(

                        isDarkTheme? Icons.toggle_on_outlined:
                        Icons.toggle_off_outlined,
                        size: 40,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ],
        ),
        body: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is Loading) {
              return Utils.loader();
            }

            if (state is PopularMovieLoaded) {
              popularMovie = state.movie;
              print("popularMovie : $popularMovie");
            }
            if (state is TopRatedMovieLoaded) {
              topRated = state.movie;
              print("topRated: $topRated");
            }
            if (state is UpComingMovieLoaded) {
              upcoming = state.movie;
              print("upcoming : $upcoming");
            }
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          builder: (context, state) {
            if (state is Initial || state is Loading) {
              return Utils.loader();
            }
            return bodyWidget();
          },
        ));
  }

  bodyWidget() {
    return
      popularMovie!=null&& popularMovie!.isNotEmpty||topRated!=null&& topRated!.isNotEmpty||upcoming!=null&& upcoming!.isNotEmpty?
      SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Popular-Movies",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  height: 340,
                  child:popularMovie!=null&& popularMovie!.isNotEmpty?  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularMovie?.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return PosterWidget(
                            id: popularMovie?[index].id,
                            score: popularMovie?[index].voteAverage,
                            date: popularMovie?[index].releaseDate,
                            posterUrl: popularMovie?[index].posterPath,
                            title: popularMovie?[index].title);
                      }):Utils.noData(),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Text(
                  "Top Rated Movies",
                  style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 340,
                child:topRated!=null&& topRated!.isNotEmpty?  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topRated?.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return PosterWidget(
                          id: topRated?[index].id,
                          score: topRated?[index].voteAverage,
                          date: topRated?[index].releaseDate,
                          posterUrl: topRated?[index].posterPath,
                          title: topRated?[index].title);
                    }):Utils.noData(),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Text(
                  "Upcoming Movies",
                  style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 340,
                child:upcoming!=null&& upcoming!.isNotEmpty? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upcoming?.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return PosterWidget(
                          id: upcoming?[index].id,
                          score: upcoming?[index].voteAverage,
                          date: upcoming?[index].releaseDate,
                          posterUrl: upcoming?[index].posterPath,
                          title: upcoming?[index].title);
                    }):Utils.noData(),
              ),
            ],
          ),
        )

    ):Utils.noData();
  }
}
