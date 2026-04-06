part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpInitialEvent extends SignUpEvent{}

class SignUpPasswordBtnClickEvent extends SignUpEvent{
  bool isHidden;

  SignUpPasswordBtnClickEvent({required this.isHidden});
}

class SignUpSignUpBtnClickedEvent extends SignUpEvent{
  String username;
  String email;
  String password;

  SignUpSignUpBtnClickedEvent({required this.username,required this.email, required this.password});
}

class SignUpSignInBtnClickedEvent extends SignUpEvent{}
