import 'dart:developer';

import 'package:ayurvedic_centre_patients/models/patient_model.dart';
import 'package:ayurvedic_centre_patients/provider/signin_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/utlit/Custom_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> fetchPatients(BuildContext context) async {
      try {
        await Provider.of<AppProvider>(context, listen: false).fetchPatients();
      } catch (e) {
        // Log the error to the console
        log("Error fetching patients: $e");
      }
    }

    String capitalizeFirstLetter(String text) {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    }

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Pallete.backgroundColor,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/signin2.png',
                  height: 40, // Adjust image size
                  fit: BoxFit.contain,
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Pallete.textcolor,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Pallete.warningred,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Search TextField
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Pallete.textfieldcordercolor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.textcolor,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Search for treatments",
                                  hintStyle: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Pallete.ash.withOpacity(0.4),
                                        ),
                                  ),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Pallete.textcolor),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Search Button
                          SizedBox(
                            height: 50,
                            width: 85,
                            child: CustomSolidButton(
                              text: "Search",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sorted By: ',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Container(
                            height: 39,
                            width: 169,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Pallete.textfieldcordercolor,
                              ),
                              borderRadius: BorderRadius.circular(33),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date',
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Pallete.ash,
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Pallete.ash.withOpacity(0.6),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Pallete.textfieldcordercolor,
                  thickness: 1,
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // This is the scrollable content
          FutureBuilder<void>(
            future: fetchPatients(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }

              if (snapshot.hasError) {
                log("Snapshot error: ${snapshot.error}");
                return const Center(
                    child: Text('Something went wrong! Please try again.'));
              }

              return Consumer<AppProvider>(
                builder: (context, provider, child) {
                  final patients = provider.patients;
                  if (patients.isEmpty) {
                    return const Center(child: Text('No patients found.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: 80), // Add padding for button space
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patient = patients[index];
                      final treatmentName = patient.patientDetails.isNotEmpty
                          ? patient.patientDetails[0].treatmentName
                          : 'No treatment available';

                      final serialNumber = index + 1;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50], // Your container color
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 3,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$serialNumber.',
                                  style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  capitalizeFirstLetter(patient.name),
                                  style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              treatmentName,
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${patient.totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_rounded),
                                    Text(
                                      patient.branch.location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Pallete.divider),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () =>
                                  _showBookingDetailsDialog(context, patient),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Booking Details',
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_right_outlined)
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          // This is the fixed button at the bottom
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomSolidButton(
              text: "Register Now",
              onPressed: () => Navigator.pushNamed(context, '/regpage'),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDetailsDialog(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Details for ${patient.name}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${patient.name}'),
                Text('Phone: ${patient.phone}'),
                Text('Address: ${patient.address}'),
                Text('Payment: ${patient.payment}'),
                Text(
                    'Total Amount: ₹${patient.totalAmount.toStringAsFixed(2)}'),
                Text(
                    'Advance Amount: ₹${patient.advanceAmount.toStringAsFixed(2)}'),
                Text(
                    'Balance Amount: ₹${patient.balanceAmount.toStringAsFixed(2)}'),
                Text('Location: ${patient.branch.location}'),
                // Add more fields as needed from the API response
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
