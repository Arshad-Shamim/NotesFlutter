class NotesModel{
  String title;
  String? description;
  int  id;
  String date;

  NotesModel({required this.title, required this.description, required this.id, required this.date});

  NotesModel.fromList({required this.title, required this.description, required this.id, required this.date}){}
}