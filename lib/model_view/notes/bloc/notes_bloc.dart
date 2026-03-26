import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/Data/api_service.dart';
import 'package:notes/Data/dbHelper.dart';
import 'package:notes/model/Notes.dart';

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
    // emit(NotesLoadingState());
    String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyD5k8SbZvCULvON1HwU8G0-uVHyMp8KtUs";
    String res = await ApiService.generateQuestion(url_p: url, title: event.title, desc: event.note!);
    Map<String,dynamic> data = jsonDecode(res);
    String questions = data["candidates"]![0]["content"]!["parts"]![0]["text"];
    emit(NoteControllerAddQGenState(data: questions));
    emit(NoteReadNoteState());
  }
}
