import 'dart:convert';

import 'package:clean_architecture/features/presentation/bloc/movie_event.dart';
import 'package:clean_architecture/features/presentation/bloc/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/crew_detail_model.dart';
import '../../data/models/movie_detail_model.dart';
import '../../data/models/movie_model.dart';
import '../../data/models/recommendation_model.dart';
import '../../data/repositories/api/movie_api.dart';
import 'package:http/http.dart' as http;

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({this.movieApiService}) : super(Initial());
  final MovieApiService? movieApiService;
  http.Response? response;
  MovieModel? movieModel;
  MovieDetailModel? movieDetailModel;
  CrewDetailModel? crewDetailModel;
  RecommendationModel? recommendationModel;

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is GetMovies) {
     try {
        yield Loading();
        response = await movieApiService!.getMovie(type: event.type);
        if (response!.statusCode == 200) {
          movieModel = MovieModel.fromJson(json.decode(response!.body));
          yield event.type == "popular"
              ? PopularMovieLoaded(movie: movieModel?.toEntity())
              : event.type == "top_rated"
                  ? TopRatedMovieLoaded(movie: movieModel?.toEntity())
                  : UpComingMovieLoaded(movie: movieModel?.toEntity());
        } else {
          yield Error(error: "Ooops something went wrong");
        }
      }catch(e){
       yield Error(error: e.toString());
     }
    }

    if (event is GetMovieDetails) {
      try{
        yield Loading();
        response = await movieApiService!.getMovieDetail(id: event.id);
        if (response!.statusCode == 200) {
          movieDetailModel =
              MovieDetailModel.fromJson(json.decode(response!.body));
          yield MovieDetailLoaded(movieDetail: movieDetailModel!.toEntity());
        } else {
          yield Error(error: "Ooops something went wrong");
        }
      }catch(e){
        yield Error(error: e.toString());
      }
    }

    if (event is GetMovieOtherDetail) {
      try{
        yield Loading();
        response = await movieApiService!
            .getMovieOtherDetail(id: event.id, otherDetail: event.otherDetail);
        if (response!.statusCode == 200) {
        if (event.otherDetail == "credits") {
            crewDetailModel =
                CrewDetailModel.fromJson(json.decode(response!.body));
          } else {
            recommendationModel =
                RecommendationModel.fromJson(json.decode(response!.body));
          }

          yield  event.otherDetail == "credits"
                  ? CrewDetailLoaded(crewDetail: crewDetailModel!.toEntity())
                  : RecommendationsLoaded(
                      recommendation: recommendationModel!.toEntity());

        } else {
          yield Error(error: "Ooops something went wrong");
        }
      }catch(e){
        yield Error(error: e.toString());
      }
    }
  }
}
