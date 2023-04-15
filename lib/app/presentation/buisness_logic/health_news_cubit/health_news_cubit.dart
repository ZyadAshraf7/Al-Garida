import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/core/constants/constants.dart';

import '../../../data/models/news_model.dart';
import '../../../data/repositories/base_news_repository.dart';

part 'health_news_state.dart';

class HealthNewsCubit extends Cubit<HealthNewsState> {
  HealthNewsCubit({required this.baseNewsRepository}) : super(HealthNewsInitial());

  BaseNewsRepository baseNewsRepository;
  List<Articles> healthNewsList = [];

  Future<void> fetchHealthNews() async {
    emit(HealthNewsLoading());
    try {
      final data = await baseNewsRepository.baseNewsRepository(healthNews);
      if (data['totalArticles'] != null || data['totalArticles'] > 0) {
        final dataRes = data['articles'] as List<dynamic>;
        healthNewsList = dataRes.map((e) => Articles.fromJson(e)).toList();
        emit(HealthNewsLoadedSuccess());
      }
    } catch (e) {
      emit(HealthNewsLoadedSuccess());
    }
  }
}
