import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/Data/dbHelper.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NotesInitialEvent>(notesInitialEvent);
    on<NotesSaveNote>(notesSaveNote);
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

  FutureOr<void> notesSaveNote(NotesSaveNote event, Emitter<NotesState> emit) async{
    String title = event.title;
    String data = event.data;

    if(title.isEmpty){
      emit(NotesUntitleNote());
    }else{
      emit(NotesLoadingState());

      DbHelper Db = DbHelper.getInstance;
      await Db.addNotes(data: data,title: title);
      print(await Db.getAllNotes());
      emit(NotesSaveNoteSuccess());
    }
  }
}
