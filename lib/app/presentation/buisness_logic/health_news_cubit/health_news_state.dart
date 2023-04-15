part of 'health_news_cubit.dart';

@immutable
abstract class HealthNewsState {}

class HealthNewsInitial extends HealthNewsState {}

class HealthNewsLoading extends HealthNewsState {}

class HealthNewsLoadedSuccess extends HealthNewsState {}

class HealthNewsError extends HealthNewsState {}
