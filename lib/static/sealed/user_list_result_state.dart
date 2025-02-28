import 'package:suitmedia_test/data/model/user.dart';

sealed class UserListResultState {}

class UserListNoneState extends UserListResultState {}

class UserListLoadingState extends UserListResultState {}

class UserListErrorState extends UserListResultState {
  final String error;

  UserListErrorState(this.error);
}

class UserListSuccessState extends UserListResultState {
  final List<User> data;

  UserListSuccessState(this.data);
}
