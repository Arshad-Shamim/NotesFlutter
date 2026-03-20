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

  void showSnackBar(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

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
          case HomeNoteDeleteSuccessState:
            showSnackBar("Note Deleted Successfully");
            break;
          case HomeNoteDeleteFailerState:
            showSnackBar("Note Delete Failed");
            homeBloc.add(HomeInitialEvent());
            break;
        }

      },
      builder: (context, state) {

        switch(state.runtimeType){
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
            break;
          case HomeDisplayNotesState:
            HomeDisplayNotesState currentState = state as HomeDisplayNotesState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("  Notepad"),
              ),              
              body:Padding(
                padding: EdgeInsets.symmetric(horizontal: 6,vertical: 10),
                child: ListView.builder(
                  itemCount: currentState.listNotesModel.length,
                  itemBuilder: (context, index) {
                    final note = currentState.listNotesModel[index];
                
                    return Dismissible(
                      key: Key(note.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction){
                        homeBloc.add(HomeNoteDeleteEvent(id: note.id));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.shade300,
                            )
                          ],
                        ),
                                      
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.notes, color: Colors.white),
                            ),
                                      
                            SizedBox(width: 10),
                                      
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                      
                                  SizedBox(height: 4),
                                      
                                  Text(
                                    note.description?? "No details added",
                                    style: TextStyle(
                                      color: note.description==null ? Colors.grey : Colors.black87,
                                      fontStyle: note.description==null ? FontStyle.italic : FontStyle.normal,
                                    ),
                                  ),
                                      
                                  SizedBox(height: 6),
                                      
                                  // Text(
                                  //   note["date"],
                                  //   style: TextStyle(
                                  //     color: Colors.grey,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                                      
                            // 🔹 Right Icons
                            SizedBox(height: 10),
                      
                            // PopupMenuButton<String>(
                            //   icon: Icon(Icons.more_vert),
                            //   onSelected: (value) {
                            //     // if (value == "edit") {
                            //     //   homeBloc.add(HomeEditNoteEvent(note));   // 👈 create this event
                            //     // } else if (value == "delete") {
                            //     //   homeBloc.add(HomeDeleteNoteEvent(note)); // 👈 create this event
                            //     // }
                            //   },
                            //   itemBuilder: (context) => [
                            //     PopupMenuItem(
                            //       value: "edit",
                            //       child: Row(
                            //         children: [
                            //           Icon(Icons.edit, size: 18),
                            //           SizedBox(width: 10),
                            //           Text("Edit"),
                            //         ],
                            //       ),
                            //     ),
                            //     PopupMenuItem(
                            //       value: "delete",
                            //       child: Row(
                            //         children: [
                            //           Icon(Icons.delete, size: 18, color: Colors.red),
                            //           SizedBox(width: 10),
                            //           Text("Delete"),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
