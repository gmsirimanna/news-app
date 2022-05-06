import 'package:flutter/cupertino.dart';

class ColorResources {
  static const Color COLOR_PRIMARY_RED = Color(0xFFFF3A44);
  static const Color COLOR_SECONDARY_BLUE = Color(0xFF0080FF);
  static const Color COLOR_TERTIARY_YELLO = Color(0xFFFFE600);
  static const Color border_blue = Color(0XFF2F60BD);
  static const Color COLOR_GREY = Color(0xFFA0A4A8);
  static const Color GREEN = Color(0xFF00B468);

  static const Color GREY_TEXT = Color(0xFF838383);
  static const Color BLUE_TEXT = Color(0xFF317C9B);
  static const Color BLACK_TEXT = Color(0xFF393939);

  static const Gradient PRIMARY_GRADIENT = LinearGradient(
    colors: [Color(0xFFFF3A44), Color.fromARGB(255, 253, 104, 113)],
  );

  static const Gradient GREY_GRADIENT = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFAf2f1f2), Color(0xFFf2f1f2)],
  );
}
