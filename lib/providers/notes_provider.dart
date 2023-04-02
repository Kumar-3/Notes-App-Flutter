import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/services/api_services.dart';

class NoteProvider with ChangeNotifier {
  bool isLoading = true;
  List<noteModel> notes = [];
  NoteProvider() {
    fetchNote();
  }

  void sortNotes() {
    notes.sort((a, b) => b.created!.compareTo(a.created!));
  }

  void addNote(noteModel note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(noteModel note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  List<noteModel> getFilteredNotes(String search) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(search.toLowerCase()) ||
            element.content!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  void deleteNote(noteModel note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void fetchNote() async {
    notes = await ApiServices.fetchNote("Kumar71");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}
