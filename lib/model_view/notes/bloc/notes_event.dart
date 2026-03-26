part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialEvent extends NotesEvent{
  final bool isEdit;
  final bool isRead;

  NotesInitialEvent({required this.isEdit, required this.isRead});
}

class NotesSaveNoteEvent extends NotesEvent{
  final String data;
  final String title;
  final String date;
  final String month;
  final String year;

  NotesSaveNoteEvent({required this.data, required this.title, required this.date, required this.month, required this.year});
}

class NoteSaveEditNoteEvent extends NotesEvent{

  final int id;
  final String title;
  final String data;
  final String date;
  final String month;
  final String year;

  NoteSaveEditNoteEvent({required this.id, required this.title, required this.data, required this.date, required this.month, required this.year});
}

class NotesQGenBtnClickEvent extends NotesEvent{
  String title;
  String? note;

  NotesQGenBtnClickEvent({required this.title,this.note});
}
