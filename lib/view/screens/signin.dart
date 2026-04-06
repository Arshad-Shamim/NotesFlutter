import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/model_view/signin/bloc/signin_bloc.dart';
import 'package:notes/view/screens/home.dart';
import 'package:notes/view/screens/signup.dart';
import 'package:notes/view/widgets/text_form_feild.dart';
import 'package:notes/view/widgets/password_form_feild.dart';


class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  SigninBloc signinBloc = SigninBloc();
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isHidden = true;

  void showSnackBar(String msg, Color? color){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color, 
        content: Text(
          msg,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );  
  }

  void initState(){
    signinBloc.add(SigninInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc:signinBloc,
      listenWhen: (previous,current) => current is SigninActionState,
      buildWhen: (previous,current)=> current is! SigninActionState,
      listener: (context,state){
        switch(state.runtimeType){
          case SigninPasswordBtnClickSuccessState:
            SigninPasswordBtnClickSuccessState currentState = state as SigninPasswordBtnClickSuccessState;
            isHidden = currentState.isHidden;
            break;
          case SigninSigninBtnClickSuccessState:
            SigninSigninBtnClickSuccessState currentState = state as SigninSigninBtnClickSuccessState;
            showSnackBar(currentState.msg, currentState.status?Colors.green:Colors.red);
            break;
          case SigninNavigateHomeScreenState:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            break;
          case SigninNavigateSignupScreen:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
            break;
        }
      },
      builder: (context,state){
        switch (state.runtimeType){
          case SigninLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          case SigninInitialState || SigninSigninBtnCircularProcessState:
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.blue,),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Image.asset(
                          "assets/form_logo.png",
                          width: 250,
                          height: 250,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        BuildTextField(
                          controller: _userNameController,
                          label: "User Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "User Name is required";
                            }
                            return null;
                          },
                        ),

                        BuildPasswordField(
                          controller: _passwordController,
                          label: "Password",
                          isHidden: isHidden,
                          onTap: () {
                            signinBloc.add(
                              SigninPasswordBtnClickEvent(isHidden: isHidden)
                            );
                          },
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Password is required";
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                signinBloc.add(SigninSigninBtnClickedEvent(username: _userNameController.text, password: _passwordController.text));
                              }
                            },
                            child: (state is! SigninSigninBtnCircularProcessState)?
                            Text("Sign In"):
                            SizedBox(width:22,height: 22,child: CircularProgressIndicator()),                          ),
                        ),

                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("do not Registered? "),
                            GestureDetector(
                              onTap: () {
                                signinBloc.add(SigninSignupBtnClickEvent());
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                ),
              ),            
            );
            break;
          default:
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }
      }
    );
  }
}