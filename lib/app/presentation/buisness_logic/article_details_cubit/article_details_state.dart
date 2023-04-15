part of 'article_details_cubit.dart';

@immutable
abstract class ArticleDetailsState {}

class ArticleDetailsInitial extends ArticleDetailsState {}
class ArticleExist extends ArticleDetailsState {}
class ArticleNotExist extends ArticleDetailsState {}
