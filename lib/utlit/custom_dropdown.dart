import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDownField extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropDownField({
    Key? key,
    required this.hintText,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        const SizedBox(height: 5),

        // Dropdown Menu
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
            ),
          ),
        ),
      ],
    );
  }
}
