part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}
abstract class SignUpActionState extends SignUpState{}

class SignUpInitialState extends SignUpState {}

class SignUpIsLoadingState extends SignUpState{}

class SignUpPasswordBtnClickedSuccessState extends SignUpActionState{
  bool isHidden;

  SignUpPasswordBtnClickedSuccessState({required this.isHidden});
}

class SignUpSignUpSuccessState  extends SignUpActionState{
  String msg;
  bool status;

  SignUpSignUpSuccessState({required this.msg, required this.status});
}

class SignUpNavigateHomeScreen extends SignUpActionState{}

class SignUpNavigateSignInScreen extends SignUpActionState{}

class SignUpSignUpCircularProcessState extends SignUpState{}