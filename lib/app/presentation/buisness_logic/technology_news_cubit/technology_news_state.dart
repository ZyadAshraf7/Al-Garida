part of 'technology_news_cubit.dart';

@immutable
abstract class TechnologyNewsState {}

class TechnologyNewsInitial extends TechnologyNewsState {}

class TechnologyNewsLoading extends TechnologyNewsState {}

class TechnologyNewsLoadedSuccess extends TechnologyNewsState {}

class TechnologyNewsError extends TechnologyNewsState {}
