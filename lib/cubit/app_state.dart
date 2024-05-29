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

class NavigationDone extends AppState {}


class SendTaskLoading extends AppState {}
class SendTaskSuccess extends AppState {}
class SendTaskFailed extends AppState {}

class GetUserInfoLoading extends AppState {}
class GetUserInfoSuccess extends AppState {}
class GetUserInfoFailed extends AppState {}

class UpdateUserInfoLoading extends AppState {}
class UpdateUserInfoSuccess extends AppState {}
class UpdateUserInfoFailed extends AppState {}


class AddDataLoading extends AppState {}
class AddDataSuccess extends AppState {}
class AddDataFailed extends AppState {}

class GetCalenderTasks extends AppState {}
class AddToCalenderTasksList extends AppState {}
class EqualityBetweenTheTwoLists extends AppState {}

class UpdateTaskSuccess extends AppState {}
class UpdateTaskLoading extends AppState {}
class UpdateTaskFailed extends AppState {}



class GetPerformanceLoading extends AppState {}
class GetPerformanceSuccess extends AppState {}
class GetPerformanceFailed extends AppState {}
class NavigatePerformanceFailed extends AppState {}