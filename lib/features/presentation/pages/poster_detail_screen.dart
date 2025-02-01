import 'package:clean_architecture/features/presentation/bloc/movie_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../domain/entities/crew_detail.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/recommendation.dart';
import '../widgets/listview_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_block.dart';
import '../bloc/movie_state.dart';

class PosterDetailScreen extends StatefulWidget {
  final String id;
  const PosterDetailScreen({super.key, required this.id});

  @override
  State<PosterDetailScreen> createState() => _PosterDetailScreenState();
}

class _PosterDetailScreenState extends State<PosterDetailScreen> {
  MovieDetail? movieDetail;
  CrewDetail? crewDetailModel;
  Recommendation? recommendation;
  String ytLink="";
  List<Cast> crew=[];

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  getMovieList() {
    BlocProvider.of<MovieBloc>(context).add(GetMovieDetails(id:widget.id));
    BlocProvider.of<MovieBloc>(context).add(GetMovieOtherDetail(id:widget.id,otherDetail:"credits"));
    BlocProvider.of<MovieBloc>(context).add(GetMovieOtherDetail(id:widget.id,otherDetail:"recommendations"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0XFF2B2B2B),
      appBar: AppBar(leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,)),
        titleSpacing: 0,
        backgroundColor: Color(0XFF032541),
        title: const Center(
            child: Text(
          "TMDB",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white,fontSize: 25),
        )),
      ),
      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is Loading) {
            return Utils.loader();
          }
          if(state is MovieDetailLoaded){
            movieDetail=state.movieDetail;
          }
          if(state is CrewDetailLoaded){
            crewDetailModel=state.crewDetail;
            crew= crewDetailModel!.crew.where((member) => member.knownForDepartment=="Acting"&&member.gender == 1)
              .toList();
            }
          if(state is RecommendationsLoaded){
            recommendation=state.recommendation;
          }
          if(state is Error){
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
  bodyWidget(){
    return   SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child:
      movieDetail!=null?
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      color: Colors.black,
                      height: 190,
                    ),
                    Expanded(
                      child: Container(
                        height: 190,
                        decoration:  BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(Constants.imageBaseUrl+ movieDetail!.backdropPath.toString()),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    height: 190,
                    width: 60,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Card(
                    shadowColor: Colors.grey,
                    child: Container(
                      width: 90,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image:  DecorationImage(
                              image: NetworkImage(
                                  Constants.imageBaseUrl+ movieDetail!.posterPath),
                              fit: BoxFit.cover)),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 25),
              child: Center(
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: movieDetail?.title.toString(), style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white,fontSize: 22),),
                        WidgetSpan(
                            child:  Text(" (${movieDetail?.releaseDate.split("-")[0]})",
                              style: TextStyle(color: Colors.grey,fontSize: 16,),
                            )
                        )
                      ]),
                ),
              ),
            ),
            const  Padding(
              padding:  EdgeInsets.only(top: 15,bottom: 15),
              child: Divider(thickness: 0.5,color: Colors.black,endIndent: 25,indent: 25,),
            ),
            Padding(
              padding:const  EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieDetail!.tagline,
                    style:const TextStyle(color: Colors.grey,fontSize: 18,fontStyle: FontStyle.italic ),
                  ),
                  const  Padding(
                    padding:   EdgeInsets.only(top: 10,bottom: 8),
                    child: Text(
                      "Overview",
                      style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                    Text(
                    movieDetail!.overview,
                    style: TextStyle(color: Colors.white70),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 10),
                    child:ListViewWidget(crew:crew),
                  ),
                const  Text(
                    "Recommendations",
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendation?.results.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return  Padding(
                            padding: const EdgeInsets.only(right: 10,top: 15),
                            child: SizedBox(
                              width: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 90,
                                    width: 160,
                                    // color: Colors.grey,
                                    decoration: BoxDecoration(
                                      // color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        image:  DecorationImage(
                                            image: NetworkImage(Constants.imageBaseUrl+ recommendation!.results[index].backdropPath.toString()),
                                            fit: BoxFit.cover)),

                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    recommendation!.results[index].title,
                                    style: TextStyle(color: Colors.grey,fontSize: 15,overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                ],
              ),
            ),

          ],
        ),
      ):
      Center(child: Text("No Data"),),
    );
  }
}
