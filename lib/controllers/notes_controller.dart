import 'package:flutter/foundation.dart';
import 'package:flutter_application_3/models/note.dart';
import 'package:flutter_application_3/repositories/note_repository.dart';

class NotesController extends ChangeNotifier {
  final NoteRepository noteRepository;

  NotesController(this.noteRepository);

  final List<Note> currentNotes = [];

  Future<void> readNotes() async {
    final fetchedNotes = await noteRepository.fetchNotes();
    currentNotes
      ..clear()
      ..addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> createNote(String textFromUser) async {
    await noteRepository.addNote(textFromUser);
    await readNotes();
  }

  Future<void> updateNote(int id, String newText) async {
    await noteRepository.updateNote(id, newText);
    await readNotes();
  }

  Future<void> deleteNote(int id) async {
    await noteRepository.deleteNote(id);
    await readNotes();
  }
}
