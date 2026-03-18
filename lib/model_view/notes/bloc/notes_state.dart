part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}
abstract class NotesActionState extends NotesState{}

final class NotesInitial extends NotesState {}

class NotesLoadingState extends NotesState{}

class NotesCreateNoteState extends NotesState{
}

class NotesEditNotesState extends NotesState{
}

class NotesUntitleNote extends NotesActionState{}

class NotesSaveNoteSuccess extends NotesActionState{}
