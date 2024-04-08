import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tile extends StatelessWidget {
  final String title;
  final String date;
  final void Function() onTap;
  final void Function()? onLongPress;

  const Tile({
    Key? key,
    required this.title,
    required this.date,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.mukta(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      subtitle: Text(
        date,
        style: GoogleFonts.jetBrainsMono(fontSize: 15),
        textAlign: TextAlign.center,
      ),
      tileColor: theme.secondaryContainer,
      textColor: theme.onSecondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

