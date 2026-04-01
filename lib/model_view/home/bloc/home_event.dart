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

class HomeNoteBtnTapEvent extends HomeEvent{
  NotesModel note;

  HomeNoteBtnTapEvent({required this.note});
}

class HomeSearchItemChangeEvent extends HomeEvent{
  String key;
  List<NotesModel> fixList;

  HomeSearchItemChangeEvent({required this.key, required this.fixList});
}
