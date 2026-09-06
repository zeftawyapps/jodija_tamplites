# 💾 التخزين المحلي وقواعد البيانات SQLite (ICrud & BaseCrudRepository)

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (LOCAL_STORAGE_AND_SQLITE.md)**](LOCAL_STORAGE_AND_SQLITE.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. نظرة عامة
توفر حزمة `JoDija Templates` معمارية متكاملة للعمل بدون إنترنت (Offline-First) من خلال واجهة `ICrud<T>` وكلاس المستودع التجريدي `BaseCrudRepository<T>` المبني على محرك SQLite.

الميزات الأساسية:
- دعم العمل عبر المنصات: أندرويد، iOS، وأنظمة الديسك توب (Windows, macOS, Linux) عبر FFI.
- عمليات جاهزة دون كتابة SQL يدوياً: إدراج، إدراج جماعي، استعلام بالمعرف، فلاتر، تحديث، وحذف.

---

## 2. واجهة العمليات `ICrud<T>`

| الدالة | المعاملات | الوصف |
| :--- | :--- | :--- |
| `insert(model)` | `T model` | إضافة سجل جديد وإرجاع الـ ID المُولد. |
| `insertAll(models)` | `List<T> models` | إضافة دفعة سجلات داخل معاملة موحدة (Transaction) فائقة السرعة. |
| `getById(id)` | `dynamic id` | استرجاع سجل واحد بواسطة المفتاح الأساسي. |
| `getAll({where, whereArgs, orderBy, limit})` | معاملات اختيارية | استرجاع قائمة السجلات مع التصفية والترتيب والتقسيم (Pagination). |
| `update(model)` | `T model` | تحديث سجل موجود بالاعتماد على مفتاحه الأساسي. |
| `delete(id)` | `dynamic id` | حذف سجل بواسطة معرفه. |
| `clear()` | لا يوجد | مسح كافة السجلات من الجدول. |

---

## 3. كود تطبيقي كامل جاهز للتشغيل (Full Runnable Example)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

// 1. تعريف الكيان
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

// 2. إنشاء المستودع (Repository)
class NotesRepository extends BaseCrudRepository<NoteModel> {
  NotesRepository()
      : super(
          tableName: "notes",
          primaryKeyColumn: "id",
          fromMap: (map) => NoteModel.fromMap(map),
        );
}

// 3. شاشة الملاحظات والعمليات
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
      title: "ملاحظة جديدة",
      content: "تمت إضافتها محلياً لقاعدة البيانات",
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
      appBar: AppBar(title: const Text("الملاحظات المحلية")),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("لا توجد ملاحظات، اضغط + للإضافة"))
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
