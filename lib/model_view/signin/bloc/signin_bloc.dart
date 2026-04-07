import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/model/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninLoadingState()) {
    on<SigninInitialEvent>(signinInitialEvent);
    on<SigninPasswordBtnClickEvent>(signinPasswordBtnClickEvent);
    on<SigninSigninBtnClickedEvent>(signinSigninBtnClickedEvent);
    on<SigninSignupBtnClickEvent>(signinSignupBtnClickEvent);
  }

  FutureOr<void> signinInitialEvent(SigninInitialEvent event, Emitter<SigninState> emit) {
    emit(SigninInitialState());
  }

  FutureOr<void> signinPasswordBtnClickEvent(SigninPasswordBtnClickEvent event, Emitter<SigninState> emit) {
    bool oldState = event.isHidden;
    bool newState = !oldState;

    emit(SigninPasswordBtnClickSuccessState(isHidden: newState));
    emit(SigninInitialState());
  }

  FutureOr<void> signinSigninBtnClickedEvent(SigninSigninBtnClickedEvent event, Emitter<SigninState> emit) async{
    emit(SigninSigninBtnCircularProcessState());

    String username = event.username;
    String password = event.password;

    dynamic res = await ApiService.Signin(username: username, password: password); 
    res = jsonDecode(res);

    if(res["status"]==1){
      final prefs = await SharedPreferences.getInstance();
      String token = res["token"];
      await prefs.setString('token', token);
    }

    print(res);

    emit(SigninSigninBtnClickSuccessState(msg:res["msg"], status: res["status"]==1?true:false));

    if(res["status"]==1){
      emit(SigninNavigateHomeScreenState());
    }else{
      emit(SigninInitialState());
    }
  }

   signinSignupBtnClickEvent(SigninSignupBtnClickEvent event, Emitter<SigninState> emit) {
    emit(SigninNavigateSignupScreen());
   }
}
