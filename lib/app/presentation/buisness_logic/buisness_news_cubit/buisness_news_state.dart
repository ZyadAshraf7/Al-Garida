part of 'buisness_news_cubit.dart';

@immutable
abstract class BuisnessNewsState {}

class BuisnessNewsInitial extends BuisnessNewsState {}

class BuisnessNewsLoading extends BuisnessNewsState {}

class BuisnessNewsLoadedSuccess extends BuisnessNewsState {}

class BuisnessNewsError extends BuisnessNewsState {}
