part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialEvent extends NotesEvent{
  final bool isEdit;

  NotesInitialEvent({required this.isEdit});
}
