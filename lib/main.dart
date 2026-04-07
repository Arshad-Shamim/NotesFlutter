import 'package:flutter/material.dart';
import 'package:notes/view/screens/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/view/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized(); // 🔴 MUST
  runApp(MyApp());}

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isAuth;

  void checkIsAuth() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    isAuth = token==null?false:true;
  }

  void initState(){
    checkIsAuth();
    setState(() {});
  }

  @override  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
      minTextAdapt: true,
      builder: (_, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: (isAuth==null)?
          Scaffold(body: Center(child: CircularProgressIndicator(),),):
          (isAuth==true)?HomeScreen():SignUp()
        );
      },
    );
  }
}

