import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model_view/notes/bloc/notes_bloc.dart';
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
                child: Column(
                  spacing: 6,
                  children: [
                    DateSection(),
                    SizedBox(height: 10,),
                    NotesPad(),
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



