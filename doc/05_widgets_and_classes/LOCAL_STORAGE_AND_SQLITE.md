# 💾 Local Storage & SQLite Architecture (ICrud & BaseCrudRepository)

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (LOCAL_STORAGE_AND_SQLITE.ar.md)**](LOCAL_STORAGE_AND_SQLITE.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. Overview
`JoDija Templates` provides an offline-first data layer based on the `ICrud<T>` contract and the `BaseCrudRepository<T>` abstract class operating directly over SQLite.

Key Highlights:
- **Universal Multi-Platform Support**: Android, iOS, and Desktop platforms (macOS, Windows, Linux) via SQLite FFI.
- **Zero Raw SQL Boilerplate**: Handles primary key bindings, batch transactions, query conditions, updates, and cascading deletes.

---

## 2. The `ICrud<T>` Interface Contract

| Method | Parameters | Description |
| :--- | :--- | :--- |
| `insert(model)` | `T model` | Inserts record into database table and returns generated primary key ID. |
| `insertAll(models)` | `List<T> models` | High-speed batch insertion executed within a single database transaction. |
| `getById(id)` | `dynamic id` | Fetches single entity by primary key. |
| `getAll({where, whereArgs, orderBy, limit})` | Optional filters | Queries records with optional sorting, WHERE constraints, and pagination limits. |
| `update(model)` | `T model` | Updates existing record matching primary key. |
| `delete(id)` | `dynamic id` | Deletes record by ID. |
| `clear()` | None | Truncates all records from this table. |

---

## 3. Full Runnable Example

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

// 1. Define Entity subclassing DataModel
class NoteModel extends DataModel {
  final String title;
  final String content;

  NoteModel({int? id, required this.title, required this.content}) : super(id: id);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
      };

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        id: map['id'],
        title: map['title'] ?? '',
        content: map['content'] ?? '',
      );
}

// 2. Concrete Repository
class NotesRepository extends BaseCrudRepository<NoteModel> {
  NotesRepository()
      : super(
          tableName: "notes",
          primaryKeyColumn: "id",
          fromMap: (map) => NoteModel.fromMap(map),
        );
}

// 3. UI Consumer Screen
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final repo = NotesRepository();
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    final data = await repo.getAll(orderBy: "id DESC");
    setState(() => notes = data);
  }

  void addNote() async {
    await repo.insert(NoteModel(
      title: "Project Milestone",
      content: "Persisted locally via JoDija BaseCrudRepository",
    ));
    loadNotes();
  }

  void deleteNote(int id) async {
    await repo.delete(id);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Local Notes (SQLite)")),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No records found. Click + to add note."))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, i) {
                final note = notes[i];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteNote(note.id as int),
                  ),
                );
              },
            ),
    );
  }
}
```
