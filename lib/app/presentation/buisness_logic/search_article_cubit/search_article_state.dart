part of 'search_article_cubit.dart';

@immutable
abstract class SearchArticleState {}

class SearchArticleInitial extends SearchArticleState {}

class SearchArticleLoading extends SearchArticleState {}

class SearchArticleSuccess extends SearchArticleState {}

class SearchArticleNoResults extends SearchArticleState {}

class SearchArticleFailed extends SearchArticleState {}
