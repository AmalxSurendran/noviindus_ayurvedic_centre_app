import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TreatmentsWidget extends StatelessWidget {
  final String title;
  final int maleCount;
  final int femaleCount;
  final VoidCallback onEditPressed;
  final TextEditingController malecoController;
  final TextEditingController femalecoController;

  const TreatmentsWidget({
    Key? key,
    required this.title,
    required this.maleCount,
    required this.femaleCount,
    required this.onEditPressed,
    required this.malecoController,
    required this.femalecoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '1. ',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Pallete.textcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Pallete.textcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.cancel,
                  color: Pallete.warningred,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                _buildGenderField(
                  context,
                  label: 'Male: $maleCount',
                  controller: malecoController,
                ),
                const Spacer(),
                _buildGenderField(
                  context,
                  label: 'Female: $femaleCount',
                  controller: femalecoController,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onEditPressed,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Pallete.buttoncolor,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 26,
          width: 44,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Border color
            borderRadius: BorderRadius.circular(6), // Rounded corners
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextFormField(
              readOnly: true,
              controller: controller,
              showCursor: false, // Hides the cursor
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              decoration: const InputDecoration(
                border: InputBorder.none, // Removes default border
                isDense: true, // Ensures the field uses minimum height
                contentPadding: EdgeInsets.zero, // Tightens padding
              ),
              textAlign: TextAlign.center, // Aligns text in the center
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black, // Replace with Pallete.textcolor if needed
              ),
            ),
          ),
        ),
      ],
    );
  }
}
