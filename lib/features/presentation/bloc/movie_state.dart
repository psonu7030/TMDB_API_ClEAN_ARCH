
import '../../domain/entities/crew_detail.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/recommendation.dart';

abstract class MovieState{}

class Initial extends MovieState{}
class Loading extends MovieState{}
class Error extends MovieState{
  String error;
  Error({required this.error});
}
class PopularMovieLoaded extends MovieState{
  List<Movie>? movie;
  PopularMovieLoaded({required this.movie});

}
class TopRatedMovieLoaded extends MovieState{
  List<Movie>? movie;
  TopRatedMovieLoaded({this.movie});
}
class UpComingMovieLoaded extends MovieState{
  List<Movie>? movie;
  UpComingMovieLoaded({required this.movie});
}

class MovieDetailLoaded extends MovieState{
 MovieDetail? movieDetail;
  MovieDetailLoaded({this.movieDetail});
}

class  CrewDetailLoaded extends MovieState{
  CrewDetail? crewDetail;
  CrewDetailLoaded({this.crewDetail});
}
class  RecommendationsLoaded extends MovieState{
  Recommendation? recommendation;
  RecommendationsLoaded({this.recommendation});
}