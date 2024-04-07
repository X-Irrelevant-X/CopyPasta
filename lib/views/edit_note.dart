import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNote extends StatefulWidget {
  final Map<String, dynamic> note;
  final int noteIndex;

  const EditNote({required this.note, required this.noteIndex, Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late final TextEditingController titleController;
  late final TextEditingController detailsController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note['title']);
    detailsController = TextEditingController(text: widget.note['details']);
  }

  Future<void> editNote(BuildContext context) async {
    final Map<String, dynamic> updatedNote = {
      'title': titleController.text,
      'details': detailsController.text,
      'createdAt': widget.note['createdAt'],
    };

    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getStringList('notes') ?? [];
    notesData[widget.noteIndex] = json.encode(updatedNote);
    await prefs.setStringList('notes', notesData);

    Navigator.pop(context);
  }

  Future<void> deleteNote(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getStringList('notes') ?? [];
    notesData.removeAt(widget.noteIndex);
    await prefs.setStringList('notes', notesData);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.note['createdAt'],
          style: TextStyle(color: theme.onBackground, fontSize: 16),
        ),
        actions: [
          IconButton(onPressed: () {
            deleteNote(context);
          }, icon: const Icon(Icons.delete))
        ],
        iconTheme: IconThemeData(color: theme.onBackground),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(
                  labelText: 'Details',
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          editNote(context);
        },
        label: const Text('Save Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.save_rounded),
        elevation: 0,
      ),
    );
  }
}
