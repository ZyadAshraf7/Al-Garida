import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/data/models/news_model.dart';
import 'package:the_news/app/data/repositories/search_artcile_repository.dart';

part 'search_article_state.dart';

class SearchArticleCubit extends Cubit<SearchArticleState> {
  SearchArticleCubit({required this.searchArticleRepository})
      : super(SearchArticleInitial());

  SearchArticleRepository searchArticleRepository;
  List<Articles> searchedArticles = [];
  TextEditingController searchWordController = TextEditingController();
  fetchSearchedArticle(String searchKeyword) async {
    emit(SearchArticleLoading());
    searchedArticles.clear();
    try {
      final response = await searchArticleRepository.searchArticle(searchKeyword);
      final List<dynamic> data = response['articles'];
      if (data.isNotEmpty) {
        searchedArticles = data.map((e) => Articles.fromJson(e)).toList();
        print(searchedArticles.length);
        emit(SearchArticleSuccess());
      } else {
        emit(SearchArticleNoResults());
      }
    } catch (e) {
      emit(SearchArticleFailed());
      print(e.toString());
    }
  }
}
