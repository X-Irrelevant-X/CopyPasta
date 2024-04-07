import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import '../screens/noteList.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CopyPasta',
      theme: ThemeData(
        colorScheme: ColScheme,
        fontFamily: GoogleFonts.mukta().fontFamily,
        useMaterial3: true,
      ),
      home: const NoteList(),
    );
  }
}
