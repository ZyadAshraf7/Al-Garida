part of 'bookmarked_articles_cubit.dart';

@immutable
abstract class BookmarkedArticlesState {}

class BookmarkedArticlesInitial extends BookmarkedArticlesState {}

class BookmarkedArticlesLoading extends BookmarkedArticlesState {}

class BookmarkedArticlesLoadedSuccess extends BookmarkedArticlesState {}
class BookmarkedArticlesEmpty extends BookmarkedArticlesState {}

class BookmarkedArticlesFailed extends BookmarkedArticlesState {}
