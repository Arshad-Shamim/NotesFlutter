import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model_view/notes/bloc/notes_bloc.dart';
import 'package:notes/view/screens/home.dart';
import 'package:notes/view/widgets/notes_date.dart';
import 'package:notes/view/widgets/notes_notepad.dart';
import 'package:flutter/services.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  NotesBloc notesBloc = NotesBloc();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  void showSnackBar(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesBloc.add(NotesInitialEvent(isEdit: false));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      bloc:notesBloc,
      listenWhen: (previous, current) => current is NotesActionState,
      buildWhen: (previous, current) => current is! NotesActionState,
      listener: (context, state) {

        switch(state.runtimeType){
          case NotesUntitleNoteState:
            showSnackBar("Note can be Untitle");
            break;
          case NotesSaveNoteSuccessState:
            showSnackBar("Note Save Successfully");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            break;
        }
      },
      builder: (context, state) {

        switch(state.runtimeType){
          case NotesInitialEvent:
            return Scaffold(body: Center(child:CircularProgressIndicator()),);
            break;
          case NotesCreateNoteState || NotesEditNotesState:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    iconSize: 28.sp,
                    onPressed: (){  
                      notesBloc.add(NotesSaveNote(data: noteController.text,title: titleController.text));
                    }, 
                    icon: Icon(Icons.save_outlined)
                  ),
                  SizedBox(width: 25.w,)
                ],
              ),
              body: SafeArea(
                child: Column(
                  spacing: 6,
                  children: [
                    DateSection(),
                    SizedBox(height: 10,),
                    NotesPad(titleController: titleController,noteController: noteController,),
                  ],
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



