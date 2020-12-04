import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameCubit extends Cubit<String> {
  UsernameCubit() : super(null);

  void validateUsername(String username) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (username.isEmpty) {
      emit('Username is required');
    } else if (!regex.hasMatch(username)) {
      emit('Username valid email');
    } else {
      emit(null);
    }
  }
}

class PasswordCubit extends Cubit<String> {
  PasswordCubit() : super(null);

  void validatePassword(String password) {
    if (password.isEmpty) {
      emit('Password is required');
    } else if (password.length < 6) {
      emit('Password must not be les than 6 characters');
    } else {
      emit(null);
    }
  }
}
