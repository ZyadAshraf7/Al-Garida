import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/core/constants/constants.dart';
import 'package:the_news/app/data/models/news_model.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';

part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  AllNewsCubit({required this.newsRepository}) : super(AllNewsInitial());

  BaseNewsRepository newsRepository;
  late List<Articles> generalNewsList = [];
  late List<Articles> worldNewsList = [];

  Future<void> fetchAllNews() async {
    emit(AllNewsLoading());
    try {
      Map<String, dynamic> data = await newsRepository.baseNewsRepository(generalNews);
      Map<String, dynamic> worldDataArticles = await newsRepository.baseNewsRepository(worldNews);
      if (data['totalArticles'] != null || data['totalArticles'] > 0) {
        final datRes = data['articles'] as List<dynamic>;
        generalNewsList = datRes.map((e) => Articles.fromJson(e)).toList();

        final worldData = worldDataArticles['articles'] as List<dynamic>;
        worldNewsList = worldData.map((e) => Articles.fromJson(e)).toList();
        emit(AllNewsLoadedSucces());
      }
    } catch (e) {
      print(e.toString());
      emit(AllNewsError());
    }
  }
}
