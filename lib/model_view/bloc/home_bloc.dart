import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notes/screens/notes.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeAddNoteBtnClickEvent>(homeAddNoteBtnClickEvent);
  }

  FutureOr<void> homeAddNoteBtnClickEvent(HomeAddNoteBtnClickEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateNoteScreenState());
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadingSuccessState());
  }
}
