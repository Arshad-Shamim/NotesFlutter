part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
class HomeLoadingState extends HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeNavigateNoteScreenState extends HomeActionState{}

class HomeDisplayNotesState extends HomeState{
  List<NotesModel> listNotesModel;

  HomeDisplayNotesState({required this.listNotesModel});
}

class HomeNoteDeleteSuccessState extends HomeActionState{}

class HomeNoteDeleteFailerState extends HomeActionState{}