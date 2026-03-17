import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model_view/notes/bloc/notes_bloc.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  NotesBloc notesBloc = NotesBloc();

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesBloc.add(NotesInitialEvent(isEdit: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      bloc:notesBloc,
      listenWhen: (previous, current) => current is NotesActionState,
      buildWhen: (previous, current) => current is! NotesActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        switch(state.runtimeType){
          case NotesInitialEvent:
            return Scaffold(body: Center(child:CircularProgressIndicator()),);
            break;
          case NotesCreateNoteState || NotesEditNotesState:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(backgroundColor: Colors.white),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20.sp,
                    vertical: 15.sp,
                  ),
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            "16",
                            style: TextStyle(
                              fontSize: 38.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "March",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "2026, Monday",
                        style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
            return Scaffold(body: Center(child:CircularProgressIndicator()),);
        }
      },
    );
  }
}
