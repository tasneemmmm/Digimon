import 'package:flutter/material.dart';

class DigimonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const DigimonTextField({
    super.key,
    this.hintText = "DIGIMON NAME",
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'BubblegumSans',
          fontSize: 16,
          color: Color(0xFF757575),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'BubblegumSans',
            fontSize: 16,
            color: Color(0xFF757575),
          ),
          filled: true,
          fillColor: Color(0xFFEFF7FE),
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFFDB2515), width: 2.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFFDB2515), width: 2.5),
          ),
        ),
      ),
    );
  }
}
