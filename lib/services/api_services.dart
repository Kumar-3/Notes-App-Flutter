import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';

import '../models/note_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String baseurl = "https://notes-app-dk34.onrender.com/notes";
  static Future<void> addNote(noteModel note) async {
    Uri reqUri = Uri.parse("$baseurl/add");
    var response = await http.post(reqUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(noteModel note) async {
    Uri reqUri = Uri.parse("$baseurl/delete");
    var response = await http.post(reqUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<noteModel>> fetchNote(String userid) async {
    Uri reqUri = Uri.parse("$baseurl/getUserNotes");
    var response = await http.post(reqUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    List<noteModel> notes = [];
    for (var noteMap in decoded) {
      noteModel newNote = noteModel.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }
}
