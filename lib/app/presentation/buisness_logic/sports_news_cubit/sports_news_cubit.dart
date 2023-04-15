import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/core/constants/constants.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';

import '../../../data/models/news_model.dart';

part 'sports_news_state.dart';

class SportsNewsCubit extends Cubit<SportsNewsState> {
  SportsNewsCubit({required this.baseNewsRepository})
      : super(SportsNewsInitial());

  BaseNewsRepository baseNewsRepository;
  List<Articles> sportsNewsList = [];

  Future<void> fetchSportsNews() async {
    emit(SportsNewsLoading());
    try {
      final data = await baseNewsRepository.baseNewsRepository(sportsNews);
      if (data['totalArticles'] != null || data['totalArticles'] > 0) {
        final dataRes = data['articles'] as List<dynamic>;
        sportsNewsList = dataRes.map((e) => Articles.fromJson(e)).toList();
        print("sports length ${sportsNewsList.length}");
        emit(SportsNewsLoadedSuccess());
      }
    } catch (e) {
      emit(SportsNewsError());
      print(e.toString());
    }
  }
}
