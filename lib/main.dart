import 'package:flutter_application_3/controllers/notes_controller.dart';
import 'package:flutter_application_3/models/note_database.dart';
import 'package:flutter_application_3/pages/notes_page.dart';
import 'package:flutter_application_3/repositories/note_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => NoteDatabase()),
        ProxyProvider<NoteDatabase, NoteRepository>(
          update: (context, noteDatabase, previous) => NoteRepository(noteDatabase),
        ),
        ChangeNotifierProxyProvider<NoteRepository, NotesController>(
          create: (context) => NotesController(context.read<NoteRepository>()),
          update: (context, noteRepository, previous) =>
              previous ?? NotesController(noteRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage()
    );
  }
}