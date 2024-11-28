// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:ayurvedic_centre_patients/provider/signin_provider.dart';
import 'package:ayurvedic_centre_patients/utlit/Custom_button.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/utlit/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PopUp extends StatefulWidget {
  const PopUp({super.key});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  void initState() {
    super.initState();

    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.fetchtreatment();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 428,
            width: 348,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                // CustomDropDownField to display the treatment list

                CustomDropDownField(
                  hintText: 'Choose Treatment',
                  label: "Choose Treatment",
                  controller: appProvider.treatmentController,
                  keyboardType: TextInputType.text,
                  items: appProvider.treatments.isNotEmpty
                      ? appProvider.treatments
                          .map((treatment) => treatment.name)
                          .toList()
                      : ['Loading...'],
                  selectedValue: appProvider.selectedTreatment,
                  onChanged: (newValue) {
                    setState(() {
                      appProvider.selectedTreatment = newValue;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Add Patients',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Spacer(),
                // Additional content here (e.g., gender selection)
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 124,
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.textfieldcordercolor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Male',
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Decrease button
                    GestureDetector(
                      onTap: () {
                        int currentValue =
                            int.tryParse(appProvider.malecoController.text) ??
                                0;
                        if (currentValue > 0) {
                          appProvider.malecoController.text =
                              (currentValue - 1).toString();

                          appProvider.notifyListeners();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.buttoncolor,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            color: Pallete.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    // The TextFormField that displays the current number
                    Container(
                      height: 44,
                      width: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.textfieldcordercolor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: appProvider.malecoController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          readOnly:
                              true, // Make the field readonly to prevent manual input
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    // Increase button
                    GestureDetector(
                      onTap: () {
                        int currentValue =
                            int.tryParse(appProvider.malecoController.text) ??
                                0;
                        appProvider.malecoController.text =
                            (currentValue + 1).toString();
                        appProvider.notifyListeners();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.buttoncolor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Pallete.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 124,
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.textfieldcordercolor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Female',
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        int currentValue =
                            int.tryParse(appProvider.femalecoController.text) ??
                                0;
                        if (currentValue > 0) {
                          appProvider.femalecoController.text =
                              (currentValue - 1).toString();

                          appProvider.notifyListeners();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.buttoncolor,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            color: Pallete.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    // The TextFormField that displays the current number
                    Container(
                      height: 44,
                      width: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.textfieldcordercolor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: appProvider.femalecoController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          readOnly:
                              true, // Make the field readonly to prevent manual input
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),

                    // Increase button
                    GestureDetector(
                      onTap: () {
                        int currentValue =
                            int.tryParse(appProvider.femalecoController.text) ??
                                0;
                        appProvider.femalecoController.text =
                            (currentValue + 1).toString();
                        appProvider.notifyListeners();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.buttoncolor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Pallete.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                CustomSolidButton(
                  text: 'Save',
                  onPressed: () {
                    int maleCount =
                        int.tryParse(appProvider.malecoController.text) ?? 0;
                    int femaleCount =
                        int.tryParse(appProvider.femalecoController.text) ?? 0;

                    String treatment = appProvider.selectedTreatment ??
                        'No treatment selected';

                    log("Male Count: $maleCount, Female Count: $femaleCount, Treatment: $treatment"); // Debugging

                    Navigator.pop(context, {
                      'treatment': treatment,
                      'maleCount': maleCount,
                      'femaleCount': femaleCount,
                    });
                  },
                ),

                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
