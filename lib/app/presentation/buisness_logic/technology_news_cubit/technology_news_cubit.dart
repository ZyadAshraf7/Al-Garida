import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/core/constants/constants.dart';
import 'package:the_news/app/data/models/news_model.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';

part 'technology_news_state.dart';

class TechnologyNewsCubit extends Cubit<TechnologyNewsState> {
  TechnologyNewsCubit({required this.baseNewsRepository}) : super(TechnologyNewsInitial());

  BaseNewsRepository baseNewsRepository;
  List<Articles> technologyNewsList = [];
  Future<void>fetchTechnolgyNews()async{
    emit(TechnologyNewsLoading());
    try {
      final data = await baseNewsRepository.baseNewsRepository(technologyNews);
      if (data['totalArticles'] != null || data['totalArticles'] > 0) {
        final dataRes = data['articles'] as List<dynamic>;
        technologyNewsList = dataRes.map((e) => Articles.fromJson(e)).toList();
        emit(TechnologyNewsLoadedSuccess());
      }
    }catch(e){
      emit(TechnologyNewsError());
      print(e.toString());
    }
  }
}
