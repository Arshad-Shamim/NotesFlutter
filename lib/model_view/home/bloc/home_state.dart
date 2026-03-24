part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
class HomeLoadingState extends HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeNavigateCreateNoteScreenState extends HomeActionState{}

class HomeDisplayNotesState extends HomeState{
  List<NotesModel> listNotesModel;

  HomeDisplayNotesState({required this.listNotesModel});
}

class HomeNoteDeleteSuccessState extends HomeActionState{}

class HomeNoteDeleteFailerState extends HomeActionState{}

class HomeNavigateEditNoteState extends HomeActionState{
  NotesModel note;
  HomeNavigateEditNoteState({required this.note});
}