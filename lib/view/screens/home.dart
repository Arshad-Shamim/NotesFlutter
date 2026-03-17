import 'package:flutter/material.dart';
import 'package:notes/model_view/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/view/screens/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc:homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {

        switch(state.runtimeType){
          case HomeNavigateNoteScreenState:
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesScreen()));
            break;
        }

      },
      builder: (context, state) {

        switch(state.runtimeType){
          case HomeInitial:
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
            break;
          case HomeLoadingSuccessState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("  Notepad"),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  homeBloc.add(HomeAddNoteBtnClickEvent());
                },
                child: Icon(Icons.add),
              ),
            );
          default:
            return Scaffold(body: Center(child: Text("Something Went Wrong!"),),);
        }
      },
    );
  }
}
