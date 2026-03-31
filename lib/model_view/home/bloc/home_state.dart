part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
class HomeLoadingState extends HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeNavigateCreateNoteScreenState extends HomeActionState{}

class HomeDisplayNotesState extends HomeState{
  final List<NotesModel> listNotesModel;
  bool isSerach=false;

  HomeDisplayNotesState({required this.listNotesModel,required this.isSerach});
}

class HomeNoteDeleteSuccessState extends HomeActionState{}

class HomeNoteDeleteFailerState extends HomeActionState{}

class HomeNavigateEditNoteState extends HomeActionState{
  final NotesModel note;
  HomeNavigateEditNoteState({required this.note});
}

class HomeNavigateReadNoteState extends HomeActionState{
  final NotesModel note;

  HomeNavigateReadNoteState({required this.note});
}
