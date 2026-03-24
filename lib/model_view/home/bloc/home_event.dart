part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeAddNoteBtnClickEvent extends HomeEvent{}

class HomeInitialEvent extends HomeEvent{}

class HomeNoteDeleteEvent extends HomeEvent{
  final int id;

  HomeNoteDeleteEvent({required this.id});
}

class HomeEditIconClickEvent extends HomeEvent{
  NotesModel note;

  HomeEditIconClickEvent({required this.note});
}
