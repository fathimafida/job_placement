import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void navigateTO(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

TextStyle applyTextStyle(
  double size,
  FontWeight weight,
) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
  );
}

TextStyle applyGoogleFontToText(
  int text,
) {
  return GoogleFonts.getFont(
    'Mooli',
    textStyle: TextStyle(
      fontSize: text.toDouble(),
      fontWeight: FontWeight.bold,
    ),
  );
}
