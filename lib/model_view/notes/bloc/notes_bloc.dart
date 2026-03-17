import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NotesInitialEvent>(notesInitialEvent);
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
}
