import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/business/business_screen.dart';
import 'package:newsapp/science/science_screen.dart';
import '../../../Sports/SportsScreen.dart';
import '../../../network/remote/dio_helper.dart';
import 'NewsStates.dart';

class NewsCubit extends Cubit<NewsStates> {
   NewsCubit() : super (NewsInitialState());
   static NewsCubit get (context)=> BlocProvider.of(context);

   int currentIndex=0;
   List<BottomNavigationBarItem>bottomItems =
   [
      const BottomNavigationBarItem(
          icon: Icon(
         Icons.business,
      ),label: 'Business'
      ),
      const BottomNavigationBarItem(
          icon: Icon(
             Icons.sports,
          ),label: 'Sports'
      ),
      const BottomNavigationBarItem(
          icon: Icon(
             Icons.science,
          ),label: 'Science'
      ),
   ];
   List <Widget>screens= [
      BusinessScreen(),
      SportsScreen(),
      ScienceScreen(),

   ];


   void changeBottomNavBar(int index)
   {
     currentIndex = index;
     if (index ==1 ){
       getSports();
     }else if (index ==2 ){
       getScience();
     }
     emit(NewsBottomNavState());
   }
   List<dynamic> business=[] ;

     void getBusiness(){
    emit(NewsLoadingBusinessState());
    DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'d6215c6e54964d49b0d3ed8d80ba4f9e'
        }
    ).then((value)
    {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));

    });
  }


   List<dynamic> sports=[] ;
   void getSports(){
     emit(NewsLoadingSportsState());
     if(sports.length ==0){
       DioHelper.getData(url: 'v2/top-headlines',
           query: {
             'country':'eg',
             'category':'sports',
             'apiKey':'d6215c6e54964d49b0d3ed8d80ba4f9e'
           }
       ).then((value)
       {
         sports = value.data['articles'];
         // print(Sports[0]['title']);
         emit(NewsGetSportsSuccessState());
       }).catchError((error){
         print(error.toString());
         emit(NewsGetSportsErrorState(error.toString()));

       });
     }
else {
  emit(NewsGetSportsSuccessState());
     }
   }

   List<dynamic> science=[] ;
   void getScience(){
     emit(NewsLoadingScienceState());
     if(science.length==0){
       DioHelper.getData(url: 'v2/top-headlines',
           query: {
             'country':'eg',
             'category':'science',
             'apiKey':'d6215c6e54964d49b0d3ed8d80ba4f9e'
           }
       ).then((value)
       {
         science = value.data['articles'];
         // print(Science[0]['title']);
         emit(NewsGetScienceSuccessState());
       }).catchError((error){
         print(error.toString());
         emit(NewsGetScienceErrorState(error.toString()));

       });
     }
     else{
       emit(NewsGetScienceSuccessState());

     }


   }



   //////////////
   List<dynamic> search = [];

   void getSearch(String value)
   {
     emit(NewsLoadingSearchState());
     search = [];
     DioHelper.getData(
       url: 'v2/everything',
       query:
       {
         'q':'$value',
         'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
       },
     ).then((value)
     {
       search = value.data['articles'];
       print(search[0]['title']);

       emit(NewsGetSearchSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(NewsGetSearchErrorState(error.toString()));
     });
   }



}