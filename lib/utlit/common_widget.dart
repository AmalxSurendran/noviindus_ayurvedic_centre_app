import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';

class CommonWidget extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? child;

  const CommonWidget({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Pallete.textcolor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Pallete.formtextcolor,
                  ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.textfieldcordercolor,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.textfieldcordercolor,
              ),
            ),
            errorStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Pallete.warningred,
            ),
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
        if (child != null) ...[
          const SizedBox(height: 10),
          child!,
        ],
      ],
    );
  }
}
