import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import the Google Fonts package

class CustomSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double opacity;
  final double width;
  final double height;
  final Color buttonColor; // New property for a solid color

  const CustomSolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 0.9,
    this.opacity = 1.0,
    this.height = 50,
    this.buttonColor = Pallete.buttoncolor, // Default to a single color
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(opacity),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 17,
                  color: Pallete.backgroundColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
