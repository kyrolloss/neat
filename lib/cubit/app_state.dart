part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class DatePickedSuccessfully extends AppState {}

class RegisterLoading extends AppState {}
class RegisterSuccess extends AppState {}
class RegisterFailed extends AppState {}


class LoginLoading extends AppState {}
class LoginSuccess extends AppState {}
class LoginFailed extends AppState {}
