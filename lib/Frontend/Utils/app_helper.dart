import 'dart:ui';

import 'package:flutter/material.dart';

class ColorHelper{

  static Color primaryColor = Color(0xff272b3d);
  static Color secondaryColor = Color(0xff474c64);

}


class DecoIn{

  InputDecoration decoInput = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    hintText: 'Search for users...',
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  );
}