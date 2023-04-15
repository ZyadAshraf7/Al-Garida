part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class InvalidPhoneNumber extends AuthenticationState {}

class EmptyPhoneNumber extends AuthenticationState {}

class VerificationLoading extends AuthenticationState {}

class VerificationFailed extends AuthenticationState {}

class VerificationSuccess extends AuthenticationState {}
