import 'package:flutter_application_3/models/note.dart';
import 'package:flutter_application_3/models/note_database.dart';

class NoteRepository {
  final NoteDatabase noteDatabase;

  NoteRepository(this.noteDatabase);

  Future<void> addNote(String text) {
    return noteDatabase.addNote(text);
  }

  Future<List<Note>> fetchNotes() {
    return noteDatabase.fetchNotes();
  }

  Future<void> updateNote(int id, String newText) {
    return noteDatabase.updateNote(id, newText);
  }

  Future<void> deleteNote(int id) {
    return noteDatabase.deleteNote(id);
  }
}
