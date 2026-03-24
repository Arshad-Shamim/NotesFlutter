import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/Data/dbHelper.dart';
import 'package:notes/model/Notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NotesInitialEvent>(notesInitialEvent);
    on<NotesSaveNoteEvent>(notesSaveNote);
    on<NoteSaveEditNoteEvent>(noteSaveEditNoteEvent);
  }

  FutureOr<void> notesInitialEvent(NotesInitialEvent event, Emitter<NotesState> emit) async{
    if(event.isEdit){
      emit(NotesLoadingState());
      await Future.delayed(Duration(seconds: 3));
      emit(NotesEditNotesState());
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
}
