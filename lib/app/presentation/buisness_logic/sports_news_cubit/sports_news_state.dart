part of 'sports_news_cubit.dart';

@immutable
abstract class SportsNewsState {}

class SportsNewsInitial extends SportsNewsState {}

class SportsNewsLoading extends SportsNewsState {}

class SportsNewsLoadedSuccess extends SportsNewsState {}

class SportsNewsError extends SportsNewsState {}
