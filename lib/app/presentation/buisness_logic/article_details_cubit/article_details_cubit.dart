import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'article_details_state.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  ArticleDetailsCubit() : super(ArticleDetailsInitial());
  bool articleExist = false;

  Future<bool> checkIfArticleExist(String? dateTime) async {
    print(FirebaseAuth.instance.currentUser?.phoneNumber);
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .get();
    final data = snapshot.data();
    List<dynamic> bookmarks = data?['bookmarks'];
    for (var artciles in bookmarks) {
      if (artciles['publishedAt'] == dateTime) {
        articleExist = true;
        emit(ArticleExist());
        return true;
      }
    }
    articleExist = false;
    emit(ArticleNotExist());
    return false;
  }

  toggleArticleExistance() {
    if (articleExist) {
      articleExist = false;
      emit(ArticleNotExist());
    } else {
      articleExist = true;
      emit(ArticleExist());
    }
  }
}
