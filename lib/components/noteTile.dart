import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String date;
  final void Function() onTap;

  const NoteTile(
      {super.key,
      required this.title,
      required this.date,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
    return Center(
      child: ListTile(
        title: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        subtitle: Center(
          child: Text(
            date,
            style: GoogleFonts.jetBrainsMono(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        tileColor: theme.secondaryContainer,
        textColor: theme.onSecondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
      ),
    );
  }
}