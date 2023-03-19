import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroButton extends StatelessWidget {
  HeroButton({
    super.key,
    required this.iconData,
    required this.text,
    required this.onPressed,
  });
  IconData iconData;
  String text;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade500,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: GoogleFonts.firaSans(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
