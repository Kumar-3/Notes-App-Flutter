import 'package:flutter/material.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App ',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ));
  }
}
