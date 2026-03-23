part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialEvent extends NotesEvent{
  final bool isEdit;

  NotesInitialEvent({required this.isEdit});
}

class NotesSaveNote extends NotesEvent{
  final String data;
  final String title;
  final String date;
  final String month;
  final String year;

  NotesSaveNote({required this.data, required this.title, required this.date, required this.month, required this.year});
}
