import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: HexColor("#036635")),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: HexColor("#036635"),
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: HexColor("#036635")),
          ],
        ),
      ),
    );
  }
}
