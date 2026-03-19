import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notes/Data/dbHelper.dart';
import 'package:notes/model/Notes.dart';
import 'package:notes/view/screens/notes.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeAddNoteBtnClickEvent>(homeAddNoteBtnClickEvent);
  }

  FutureOr<void> homeAddNoteBtnClickEvent(HomeAddNoteBtnClickEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateNoteScreenState());
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    print("hi");
    DbHelper Db = DbHelper.getInstance;
    List<Map<String,dynamic>> notesData = await Db.getAllNotes();
    List<NotesModel> notesModel = notesData.map((e)=>NotesModel.fromList(title: e["title"].trim(), description: e["data"]==""?null:e["data"].trim(), id: e["id"])).toList();
    print(notesModel);
    emit(HomeDisplayNotesState(listNotesModel: notesModel));
  }
}
