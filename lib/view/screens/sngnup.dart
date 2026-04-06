import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/model_view/signin/bloc/signin_bloc.dart';
import 'package:notes/model_view/signup/bloc/sign_up_bloc.dart';
import 'package:notes/view/screens/home.dart';
import 'package:notes/view/screens/signin.dart';
import 'package:notes/view/widgets/password_form_feild.dart';
import 'package:notes/view/widgets/text_form_feild.dart';



class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  SignUpBloc signUpBloc = SignUpBloc();
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isHidden= true;

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
    signUpBloc.add(SignUpInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc,SignUpState>(
      bloc:signUpBloc,
      listenWhen: (previous,current){ return current is SignUpActionState;},
      buildWhen: (previous,current){ return current is! SignUpActionState;},
      listener: (context,state){
        switch (state.runtimeType){
          case SignUpPasswordBtnClickedSuccessState:
            SignUpPasswordBtnClickedSuccessState currentState = state as SignUpPasswordBtnClickedSuccessState;
            isHidden = currentState.isHidden;
            break;
          case SignUpSignUpSuccessState:
            SignUpSignUpSuccessState currentState = state as SignUpSignUpSuccessState;
            showSnackBar(currentState.msg, currentState.status?Colors.green:Colors.red);
            break;
          case SignUpNavigateSignInScreen:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signin()));
            break;
          case SigninNavigateHomeScreenState:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            break;
        }
      },
      builder: (context,state){
        switch (state.runtimeType){
          case SignUpIsLoadingState:
            return Scaffold(body: Center(child:CircularProgressIndicator()),);
            break;
          case SignUpInitialState || SignUpSignUpCircularProcessState:
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
                          "Register Yourself",
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

                        BuildTextField(
                          controller: _emailController,
                          label: "Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            else if(!value.contains("@")){
                              return "email is invalid";
                            }
                            return null;
                          },
                        ),

                        BuildPasswordField(
                          controller: _passwordController,
                          label: "Password",
                          isHidden: isHidden,
                          onTap: () {
                            signUpBloc.add(
                              SignUpPasswordBtnClickEvent(isHidden: isHidden),
                            );
                          },
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Password is required";
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                signUpBloc.add(SignUpSignUpBtnClickedEvent(username: _userNameController.text, email: _emailController.text, password: _passwordController.text));
                              }
                            },
                            child: (state is! SignUpSignUpCircularProcessState)?
                            Text("Sign Up"):
                            SizedBox(width:22,height: 22,child: CircularProgressIndicator()),
                          ),
                        ),

                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Registered? "),
                            GestureDetector(
                              onTap: () {
                                signUpBloc.add(SignUpSignInBtnClickedEvent());
                              },
                              child: Text(
                                "Sign In",
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
            return Scaffold(body: Center(child:CircularProgressIndicator()),);
        }
      }
    );
  }
}