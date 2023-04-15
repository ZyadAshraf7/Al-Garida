part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadedSuccess extends ProfileState {}
class ChangeProfilePictureLoading extends ProfileState {}
class ChangeProfilePictureSuccess extends ProfileState {}
class ChangeProfilePictureFailed extends ProfileState {}

class ProfileFailed extends ProfileState {}
