import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notes/Data/dbHelper.dart';
import 'package:notes/model/Notes.dart';
import 'package:notes/view/screens/notes.dart';
import 'package:notes/Data/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeAddNoteBtnClickEvent>(homeAddNoteBtnClickEvent);
    on<HomeNoteDeleteEvent>(homeNoteDeleteEvent);
    on<HomeEditIconClickEvent>(homeEditIconClickEvent);
  }

  FutureOr<void> homeAddNoteBtnClickEvent(HomeAddNoteBtnClickEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateCreateNoteScreenState());
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    DbHelper Db = DbHelper.getInstance;
    List<Map<String,dynamic>> notesData = await Db.getAllNotes();
    List<NotesModel> notesModel = notesData.map((e)=>NotesModel.fromList(title: e["title"].trim(), description: e["data"]==""?null:e["data"].trim(), id: e["id"], date: e["create_date"]),).toList();

    await Future.delayed(Duration(seconds: 5));
    emit(HomeDisplayNotesState(listNotesModel: notesModel));
  }

  FutureOr<void> homeNoteDeleteEvent(HomeNoteDeleteEvent event, Emitter<HomeState> emit) async{
    int id = event.id;

    DbHelper DB = DbHelper.getInstance;
    bool status = await DB.deleteNote(id: id);

    if(status){
      emit(HomeNoteDeleteSuccessState());
    }else{
      emit(HomeNoteDeleteFailerState());
    }
  }

  FutureOr<void> homeEditIconClickEvent(HomeEditIconClickEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateEditNoteState(note: event.note));
  }
}


//here HomeNoteDeletedFailerState is not handled properly
