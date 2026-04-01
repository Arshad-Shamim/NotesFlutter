import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model/Notes.dart';
import 'package:notes/model/note_question.dart';
import 'package:notes/model_view/home/bloc/home_bloc.dart';
import 'package:notes/model_view/notes/bloc/notes_bloc.dart';
import 'package:notes/view/screens/home.dart';
import 'package:notes/view/widgets/notes_date.dart';
import 'package:notes/view/widgets/notes_notepad.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';



class NotesScreen extends StatefulWidget {

  final bool isEdit;
  final bool isRead;
  NotesModel? note;

  NotesScreen({super.key, required this.isEdit, this.note,required this.isRead,});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  NotesBloc notesBloc = NotesBloc();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late DateTime now;
  late String date, month, year, day, monthNumber;
  late bool isEdit;
  NotesModel? note;
  late bool isRead;
  List<NoteQuestion>? quesList;

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

  void handleEditMode(NotesModel note){
    titleController.text = note.title;
    noteController.text = note.description??"No Content";
    notesBloc.add(NotesInitialEvent(isEdit: true, isRead: false));
  }

  void handleReadMode(NotesModel note){
    titleController.text = note.title;
    noteController.text=note.description??"No Content";
    // final now = DateTime.parse(note.date);
    notesBloc.add(NotesInitialEvent(isEdit: false, isRead: true));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    isEdit = widget.isEdit;
    isRead = widget.isRead;
    
    if(!isRead){
      now = DateTime.now();
    }else{
      now = DateTime.parse(widget.note!.date);
    }

    date = DateFormat("dd").format(now);
    month = DateFormat("MMMM").format(now);
    year = DateFormat("yyyy").format(now);
    day = DateFormat("EEEE").format(now);
    monthNumber =  DateFormat("MM").format(now);
    if(isEdit || isRead){
      note = widget.note!;
    }

    if(isEdit){
      handleEditMode(widget.note!);
    }else if(isRead){
      handleReadMode(widget.note!);
    }else{
      notesBloc.add(NotesInitialEvent(isEdit:false,isRead: false));
    }
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
            showSnackBar("Note can not be Untitle",Colors.red);
            break;
          case NotesSaveNoteSuccessState:
            showSnackBar("Note Save Successfully",Colors.green);
            Navigator.pop(context,true);
            break;
          case NoteEditNoteSuccessState:
            showSnackBar("Note Edit Successfully!",Colors.green);
            Navigator.pop(context,true);
            break;
          case NoteEmptyNoteDescState:
            showSnackBar("Note Data is Empty!",Colors.red);
            break;
          case NoteAddQuesListState:
            NoteAddQuesListState currentState = state as NoteAddQuesListState;
            quesList = currentState.data;
            break;
          case NoteQGenBtnFailState:
            NoteQGenBtnFailState currentState = state as NoteQGenBtnFailState;
            showSnackBar(state.msg,Colors.red);
            break;

        }
      },
      builder: (context, state) {

        switch(state.runtimeType){
          case NotesLoadingState:
            return Scaffold(body: Center(child:CircularProgressIndicator()),);
            break;
          case NotesCreateNoteState || NotesEditNotesState || NoteReadNoteState || NoteQGenBtnClickSuccessState || NotesQGenBtnLoadingState:

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: 
                  !isRead?
                  [      
                    IconButton(
                      iconSize: 28.sp,
                      onPressed: (){
                        if(isEdit){
                          notesBloc.add(NoteSaveEditNoteEvent(id: note!.id, title: titleController.text, data: noteController.text, date: date, month: monthNumber, year: year));
                        }else{
                          notesBloc.add(NotesSaveNoteEvent(data: noteController.text,title: titleController.text, date: date, month: monthNumber, year: year));
                        }
                      }, 
                      icon: Icon(Icons.save_outlined)
                    ),
                    SizedBox(width: 25.w,)
                  ]:
                  [
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ElevatedButton(
                        onPressed: () {
                          notesBloc.add(NotesQGenBtnClickEvent(title: titleController.text,note: noteController.text));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: 
                            state is!  NotesQGenBtnLoadingState? [
                              Icon(Icons.quiz, size: 18.sp),
                              SizedBox(width: 5.w),                              
                              Text("Q-Gen"),
                            ]: [
                              SizedBox(height: 20.h,width: 20.w,child: CircularProgressIndicator())
                            ]
                        ),
                      ),
                    )
                  ]
                ,
              ),
              body: SafeArea(
                child: Column(
                  spacing: 6,
                  children: [
                    DateSection(date: date, month: month, year: year, day: day),
                    SizedBox(height: 10,),

                    NotesPad(titleController: titleController,noteController: noteController, quesList: quesList),
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



