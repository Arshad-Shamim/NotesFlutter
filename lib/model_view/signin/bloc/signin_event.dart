part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class SigninInitialEvent extends SigninEvent{}

class SigninPasswordBtnClickEvent extends SigninEvent{
  bool isHidden;

  SigninPasswordBtnClickEvent({required this.isHidden});
}

class SigninSigninBtnClickedEvent extends SigninEvent{
  String username;
  String password;

  SigninSigninBtnClickedEvent({required this.username, required this.password});
}

class SigninSignupBtnClickEvent extends SigninEvent{}
