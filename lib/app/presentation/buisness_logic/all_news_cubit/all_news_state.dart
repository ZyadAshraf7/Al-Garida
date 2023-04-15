part of 'all_news_cubit.dart';

@immutable
abstract class AllNewsState {}

class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {}

class AllNewsLoadedSucces extends AllNewsState {}

class AllNewsError extends AllNewsState {}
