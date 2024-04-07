import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/noteTile.dart';
import '../screens/addNote.dart';
import '../screens/editNote.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Map<String, dynamic>> notes = [];
  bool isRefreshed = false;

  @override
  void initState() {
    super.initState();
    notes = [];
    constRefresh();
  }

  Future<void> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getStringList('notes');
    if (notesData != null) {
      setState(() {
        notes = notesData.map((note) => json.decode(note)).cast<Map<String, dynamic>>().toList();
      });
    }
  }

  void refreshNotes() {
    if (!isRefreshed) {
      getNotes();
      setState(() {
        isRefreshed = true;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isRefreshed = false;
        });
      });
    }
  }

  void constRefresh() {
    Timer.periodic(const Duration(seconds: 0), (Timer timer) {
      getNotes();
    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text(
          'CopyPasta',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        actionsIconTheme: IconThemeData(color: theme.onPrimaryContainer),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              // Handle Add Link button press
            },
            label: const Text('Add Link', style: TextStyle(fontSize: 16)),
            icon: const Icon(Icons.link),
            elevation: 0,
          ),
          const SizedBox(width: 15),
          FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => const AddNote());
            },
            label: const Text('Add Note', style: TextStyle(fontSize: 16)),
            icon: const Icon(Icons.add_rounded),
            elevation: 0,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: refreshNotes,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: NoteTile(
                title: note['title'],
                date: note['createdAt'],
                onTap: () {
                  Get.to(() => EditNote(note: note, noteIndex: index));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
