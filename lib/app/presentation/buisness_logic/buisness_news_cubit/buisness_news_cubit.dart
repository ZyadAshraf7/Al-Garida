import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/core/constants/constants.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';

import '../../../data/models/news_model.dart';

part 'buisness_news_state.dart';

class BuisnessNewsCubit extends Cubit<BuisnessNewsState> {
  BuisnessNewsCubit({required this.baseNewsRepository})
      : super(BuisnessNewsInitial());

  BaseNewsRepository baseNewsRepository;
  List<Articles> buisnessNewsList = [];

  Future<void> fetchBuisnessNews() async {
    emit(BuisnessNewsLoading());
    try {
      final data = await baseNewsRepository.baseNewsRepository(buisnessNews);
      if (data['totalArticles'] != null || data['totalArticles'] > 0) {
        final dataRes = data['articles'] as List<dynamic>;
        buisnessNewsList = dataRes.map((e) => Articles.fromJson(e)).toList();
        emit(BuisnessNewsLoadedSuccess());
      }
    } catch (e) {
      emit(BuisnessNewsError());
    }
  }
}
