import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/Data/api_service.dart';
import 'package:notes/Data/dbHelper.dart';
import 'package:notes/model/Notes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NotesInitialEvent>(notesInitialEvent);
    on<NotesSaveNoteEvent>(notesSaveNote);
    on<NoteSaveEditNoteEvent>(noteSaveEditNoteEvent);
    on<NotesQGenBtnClickEvent>(notesQGenBtnClickEvent);
  }

  FutureOr<void> notesInitialEvent(NotesInitialEvent event, Emitter<NotesState> emit) async{
    if(event.isEdit){
      emit(NotesLoadingState());
      await Future.delayed(Duration(seconds: 1));
      emit(NotesEditNotesState());
    }else if(event.isRead){
      emit(NotesLoadingState());
      await Future.delayed(Duration(seconds: 1));
      emit(NoteReadNoteState());
    }else{
      emit(NotesCreateNoteState());
    }
  }

  FutureOr<void> notesSaveNote(NotesSaveNoteEvent event, Emitter<NotesState> emit) async{
    String title = event.title;
    String data = event.data;
    final date = "${event.year}-${event.month}-${event.date}";

    if(title.isEmpty){
      emit(NotesUntitleNoteState());
    }else{
      emit(NotesLoadingState());

      DbHelper Db = DbHelper.getInstance;
      await Db.addNotes(data: data,title: title,date: date);
      emit(NotesSaveNoteSuccessState());
    }
  }

  FutureOr<void> noteSaveEditNoteEvent(NoteSaveEditNoteEvent event, Emitter<NotesState> emit) async{

    final String date = "${event.year}-${event.month}-${event.date}";
    final String title = event.title;
    final String data = event.data;
    final int id = event.id;

    if(title.isEmpty){
      emit(NotesUntitleNoteState());
    }else{
      emit(NotesLoadingState());

      DbHelper DB = DbHelper.getInstance;
      bool status = await DB.updateNote(note: NotesModel(title: title, description: data, id: id, date: date));

      if(status){
        emit(NoteEditNoteSuccessState());
      }
      else{
        print("result $status");
      }
    }
  }

  FutureOr<void> notesQGenBtnClickEvent(NotesQGenBtnClickEvent event, Emitter<NotesState> emit) async{
    if(event.note==null){
      emit(NoteEmptyNoteDescState());
    }
    await dotenv.load(fileName: '.env');
    emit(NotesQGenBtnLoadingState());
    String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${dotenv.env['API_KEY']}";
    dynamic res = await ApiService.generateQuestion(url_p: url, title: event.title, desc: event.note!);

    if(res.statusCode!=200){
      Map<String,dynamic> data = jsonDecode(res.body);      
      emit(NoteQGenBtnFailState(msg: data["error"]["message"]));
      emit(NoteReadNoteState());
      return;
    }

    res = res.body;
    Map<String,dynamic> data = jsonDecode(res);
    String questions = data["candidates"]![0]["content"]!["parts"]![0]["text"];

    List<Map<String,String>> quesList = [];

    questions.trim();
    int size = questions.length;
    int c1=0;
    while(c1<size){
      Map<String,String> helperMap={};

      while(questions[c1]!='['){
        c1++;
      }
      c1++;

      int st,end;
      st=c1;
      while(questions[c1]!='|'){
        c1++;
      }
      end=c1;
      c1++;

      String ques = questions.substring(st,end);
      helperMap["ques"] = ques;

      while(questions[c1]==' '){
        c1++;
      }

      st=c1;
      while(questions[c1]!=']'){
        c1++;
      }
      end = c1;
      c1++;
      String hint = questions.substring(st,end);
      helperMap["hint"]=hint;

      quesList.add(helperMap);
    }



    emit(NoteAddQuesListState(data: quesList));
    emit(NoteQGenBtnClickSuccessState());
  }
}
