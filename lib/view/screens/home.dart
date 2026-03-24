import 'package:flutter/material.dart';
import 'package:notes/model_view/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/view/screens/notes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      listener: (context, state) async{

        switch(state.runtimeType){
          case HomeNavigateNoteScreenState:
            final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesScreen()));
            if(result!=null && result){
              homeBloc.add(HomeInitialEvent());
            }
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
          case HomeDisplayNotesState:
            HomeDisplayNotesState currentState = state as HomeDisplayNotesState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("  Notepad"),
              ),              
              body:Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 10.h),
                child: ListView.builder(
                  itemCount: currentState.listNotesModel.length,
                  itemBuilder: (context, index) {

                    final note = currentState.listNotesModel[index];
                    final date = note.date.trim();
                    final year = date.substring(0,4);
                    final month = date.substring(5,7);
                    final datenum =  date.substring(8);

                    return Dismissible(
                      key: Key(note.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction){
                        homeBloc.add(HomeNoteDeleteEvent(id: note.id));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.r,
                              color: Colors.grey.shade300,
                            )
                          ],
                        ),
                                      
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 22.r,
                              child: Icon(Icons.notes, color: Colors.white,size: 28.r,),
                            ),
                                      
                            SizedBox(width: 10.w),
                                      
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                      
                                  SizedBox(height: 4.h),
                                      
                                  Text(
                                    note.description!=null?(note.description!.substring(0,note.description!.length>40?40:note.description!.length)+(note.description!.length>40?".....":"")): "No details added",
                                    style: TextStyle(
                                      color: note.description==null ? Colors.grey : Colors.black87,
                                      fontStyle: note.description==null ? FontStyle.italic : FontStyle.normal,
                                    ),
                                  ),
                                      
                                  SizedBox(height: 6.h),
                                      
                                  Text(
                                    "$datenum/$month/$year",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                      
                            // 🔹 Right Icons
                            SizedBox(height: 10.h),
                      
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
