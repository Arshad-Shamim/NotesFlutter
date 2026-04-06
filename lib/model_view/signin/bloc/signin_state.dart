part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}
abstract class SigninActionState extends SigninState{}

class SigninLoadingState extends SigninState {}

class SigninInitialState extends SigninState{}

class SigninPasswordBtnClickSuccessState extends SigninActionState{
  bool isHidden;

  SigninPasswordBtnClickSuccessState({required this.isHidden});
}

class SigninNavigateHomeScreenState extends SigninActionState{}

class SigninSigninBtnClickSuccessState extends SigninActionState{
  String msg;
  bool status;

  SigninSigninBtnClickSuccessState({required this.msg, required this.status});
}

class SigninNavigateSignupScreen extends SigninActionState{}

class SigninSigninBtnCircularProcessState extends SigninState{}
