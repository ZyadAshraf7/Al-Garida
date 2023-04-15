import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/data/models/news_model.dart';

part 'bookmarked_articles_state.dart';

class BookmarkedArticlesCubit extends Cubit<BookmarkedArticlesState> {
  BookmarkedArticlesCubit() : super(BookmarkedArticlesInitial());
  List<Articles>bookmarkedArticles = [];
  fetchBookMarkedArticles()async{
    emit(BookmarkedArticlesLoading());
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
          .get();
      final data = snapshot.data();
      List<dynamic> bookmarks = data!['bookmarks'];
      bookmarkedArticles = bookmarks.map((e) => Articles.fromJson(e)).toList();
      if(bookmarkedArticles.isNotEmpty){
        emit(BookmarkedArticlesLoadedSuccess());
      }else{
        emit(BookmarkedArticlesEmpty());
      }
    }catch(e){
      print(e.toString());
      emit(BookmarkedArticlesFailed());
    }
  }

}
