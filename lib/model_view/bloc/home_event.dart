part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeAddNoteBtnClickEvent extends HomeEvent{}

class HomeInitialEvent extends HomeEvent{}
