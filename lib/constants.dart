import 'package:flutter/material.dart';

const kDefaultText = "The quick brown fox jumps over the lazy dog";

const kLightSplashColor = Color(0xFFF9F9F9);
const kLightDividerColor = Color(0xFFDADCE0);
const kLightInputFillColor = Color(0xFFE0E0E0);
const kDarkSplashColor = Color(0xFF28292C);
const kDarkDividerColor = Color(0xFF606367);
const kDarkInputFillColor = Color(0xFF363636);
const kDarkScaffoldColor = Color(0xFF202124);

const kSearchFieldDecoration = InputDecoration(
  hintText: "Type Something",
  border: UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomLeft: Radius.circular(30),
    ),
  ),
);
const kInputTextFormDecoration = InputDecoration(
  hintText: "Type Something",
  border: UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomLeft: Radius.circular(30),
    ),
  ),
);
const kDropdownButtonDecoration = InputDecoration(
  prefixIcon: Center(child: Icon(Icons.format_size)),
  prefixIconConstraints: BoxConstraints(maxWidth: 32, maxHeight: 24),
  border: UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
  ),
);
