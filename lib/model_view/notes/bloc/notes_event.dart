part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialEvent extends NotesEvent{
  final bool isEdit;

  NotesInitialEvent({required this.isEdit});
}

class NotesSaveNote extends NotesEvent{
  final String title;
  final String data;

  NotesSaveNote({required this.data,required this.title});
}
