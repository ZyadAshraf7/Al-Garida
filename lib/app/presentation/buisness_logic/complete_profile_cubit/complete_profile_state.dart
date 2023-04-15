part of 'complete_profile_cubit.dart';

@immutable
abstract class CompleteProfileState {}

class CompleteProfileInitial extends CompleteProfileState {}

class IncompleteInformation extends CompleteProfileState {}

class ProfileInfoCompleted extends CompleteProfileState {}

class UploadProfileLoading extends CompleteProfileState {}

class UploadProfileSuccess extends CompleteProfileState {}

class UploadProfileFailed extends CompleteProfileState {}

class FetchProfilePhotoLoading extends CompleteProfileState {}

class FetchProfilePhotoSuccess extends CompleteProfileState {}

class FetchProfilePhotoFailed extends CompleteProfileState {}

class ModifyGender extends CompleteProfileState {}
