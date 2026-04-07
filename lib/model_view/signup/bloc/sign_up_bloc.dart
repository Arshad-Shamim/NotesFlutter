import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/model/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpIsLoadingState()) {
    on<SignUpInitialEvent>(signUpInitialEvent);
    on<SignUpPasswordBtnClickEvent>(signUpPasswordBtnClickEvent);
    on<SignUpSignUpBtnClickedEvent>(signUpSignUpBtnClickedEvent);
    on<SignUpSignInBtnClickedEvent>(signUpSignInBtnClickedEvent);
  }

  FutureOr<void> signUpInitialEvent(SignUpInitialEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitialState());
  }

  FutureOr<void> signUpPasswordBtnClickEvent(SignUpPasswordBtnClickEvent event, Emitter<SignUpState> emit) {
    bool preValue = event.isHidden;
    bool newValue = !preValue;

    emit(SignUpPasswordBtnClickedSuccessState(isHidden: newValue));
    emit(SignUpInitialState());
  }



  FutureOr<void> signUpSignUpBtnClickedEvent(SignUpSignUpBtnClickedEvent event, Emitter<SignUpState> emit) async{
    emit(SignUpSignUpCircularProcessState());

    String username = event.username;
    String email = event.email;
    String password = event.password;

    Map<String,String> formData = {"username":username,"email":email,"pws":password};

    dynamic res = await ApiService.SignUp(formData: formData);
    res = jsonDecode(res);

    if(res["status"]==1){
      final prefs = await SharedPreferences.getInstance();
      String token = res["token"];
      await prefs.setString('token', token);
    }
    

    emit(SignUpSignUpSuccessState(msg: res["msg"],status: res["status"]==1?true:false));

    if(res["status"]==1){
      emit (SignUpNavigateHomeScreen());
    }else{
      emit(SignUpInitialState());
    }
  }

  FutureOr<void> signUpSignInBtnClickedEvent(SignUpSignInBtnClickedEvent event, Emitter<SignUpState> emit) {

    emit(SignUpNavigateSignInScreen());
  }
}
