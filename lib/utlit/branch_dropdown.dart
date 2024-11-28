import 'package:ayurvedic_centre_patients/models/branch_model.dart';
import 'package:ayurvedic_centre_patients/services/app_services.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchDropdown extends StatefulWidget {
  @override
  _BranchDropdownState createState() => _BranchDropdownState();
}

class _BranchDropdownState extends State<BranchDropdown> {
  String? selectedBranch;
  late ApiService _apiService;
  late Future<List<Branch>> _branchesFuture;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _branchesFuture = _apiService
        .getBranches(); // Ensure this is returning the branches correctly
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Branch>>(
      future: _branchesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No branches available');
        } else {
          List<Branch> branches = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label text
              Text(
                'Select a branch', // Optional: You can customize the label
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              const SizedBox(height: 5), // Space between label and dropdown

              // Dropdown Menu
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedBranch,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBranch = newValue;
                    });
                  },
                  items: branches.map((Branch branch) {
                    return DropdownMenuItem<String>(
                      value: branch.name,
                      child: Text(branch.name),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Choose a branch ', // Custom hint text
                    hintStyle: GoogleFonts.inter(
                      textStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Pallete
                                    .formtextcolor, // Ensure this color exists
                              ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Pallete
                            .textfieldcordercolor, // Ensure this color exists
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Pallete
                            .textfieldcordercolor, // Ensure this color exists
                      ),
                    ),
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.warningred, // Ensure this color exists
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
