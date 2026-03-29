part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}
abstract class NotesActionState extends NotesState{}

final class NotesInitial extends NotesState {}

class NotesLoadingState extends NotesState{}

class NotesCreateNoteState extends NotesState{
}

class NotesEditNotesState extends NotesState{}

class NotesUntitleNoteState extends NotesActionState{}

class NotesSaveNoteSuccessState extends NotesActionState{}

class NoteEditNoteSuccessState extends NotesActionState{}

class NoteReadNoteState extends NotesState{}

class NoteEmptyNoteDescState extends NotesActionState{}

class NoteQGenBtnClickSuccessState extends NotesState{}


class NoteAddQuesListState extends NotesActionState{
  List<Map<String,String>> data;

  NoteAddQuesListState({required this.data});
}

class NotesQGenBtnLoadingState extends NotesState{}

class NoteQGenBtnFailState extends NotesActionState{
  String msg;

  NoteQGenBtnFailState({required this.msg});
}
