import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNote extends StatefulWidget {
  final bool isUpdate;
  final noteModel? note;
  const AddNote({super.key, required this.isUpdate, this.note});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode nodefocus = FocusNode();

  void addNewNote() {
    noteModel newNote = noteModel(
        id: const Uuid().v1(),
        userid: 'Kumar71',
        title: titleController.text,
        content: contentController.text,
        created: DateTime.now());
    Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.created = DateTime.now();
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isUpdate) {
                  updateNote();
                } else {
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (val) {
                if (val != null) {
                  nodefocus.requestFocus();
                }
              },
              autofocus: (widget.isUpdate == true) ? false : true,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  hintText: "Title", border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: nodefocus,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Note", border: InputBorder.none),
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
