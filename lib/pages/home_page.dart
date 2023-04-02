import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/add_new_note.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: (noteProvider.isLoading == false)
          ? SafeArea(
              child: (noteProvider.notes.isNotEmpty)
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                search = val;
                              });
                            },
                            decoration: InputDecoration(hintText: "Search"),
                          ),
                        ),
                        (noteProvider.getFilteredNotes(search).length > 0)
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: noteProvider
                                    .getFilteredNotes(search)
                                    .length,
                                itemBuilder: (context, index) {
                                  noteModel currentNote = noteProvider
                                      .getFilteredNotes(search)[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => AddNote(
                                                    isUpdate: true,
                                                    note: currentNote,
                                                  )));
                                    },
                                    onLongPress: () {
                                      noteProvider.deleteNote(currentNote);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentNote.title!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            currentNote.content!,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey[700]),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text("No data found"),
                                ),
                              ),
                      ],
                    )
                  : const Center(
                      child: Text("No Notes yet"),
                    ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNote(
                        isUpdate: false,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
