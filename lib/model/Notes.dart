class NotesModel{
  String title;
  String? description;
  int  id;

  NotesModel({required this.title, required this.description, required this.id});

  NotesModel.fromList({required this.title, required this.description, required this.id}){}
}