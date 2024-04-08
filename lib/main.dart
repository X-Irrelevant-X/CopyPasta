import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:copypasta/templates/theme.dart';
import 'package:copypasta/views/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CopyPasta',
      theme: ThemeData(
        colorScheme: ColScheme,
        fontFamily: GoogleFonts.mukta().fontFamily,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
