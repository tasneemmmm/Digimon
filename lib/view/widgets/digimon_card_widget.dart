import 'package:flutter/material.dart';
import 'package:api_project/model/digimon_model.dart';

class DigimonCard extends StatefulWidget {
  final DigimonModel digimon;

  const DigimonCard({super.key, required this.digimon});

  @override
  State<DigimonCard> createState() => _DigimonCardState();
}

class _DigimonCardState extends State<DigimonCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
        height: 385,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isTapped ? Color(0xFFCC898F) : Color(0xFF8F8B6A),
              blurRadius: 20,
              spreadRadius: 4,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.digimon.name,
              style: TextStyle(
                fontFamily: 'BubblegumSans',
                fontSize: 40,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 12),
            Image.network(widget.digimon.img, width: 185, height: 190),

            SizedBox(height: 12),
            Text(
              widget.digimon.level,
              style: TextStyle(
                fontFamily: 'BubblegumSans',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
