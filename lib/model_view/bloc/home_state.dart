part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeNavigateNoteScreenState extends HomeActionState{}

class HomeLoadingSuccessState extends HomeState{}