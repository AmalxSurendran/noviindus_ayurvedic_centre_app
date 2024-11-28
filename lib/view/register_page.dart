import 'package:ayurvedic_centre_patients/services/pdf_services.dart';
import 'package:ayurvedic_centre_patients/utlit/Custom_button.dart';
import 'package:ayurvedic_centre_patients/utlit/branch_dropdown.dart';
import 'package:ayurvedic_centre_patients/utlit/custom_dropdown.dart';
import 'package:ayurvedic_centre_patients/utlit/treatment_widget.dart';
import 'package:ayurvedic_centre_patients/view/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/utlit/customfield.dart';
import 'package:ayurvedic_centre_patients/provider/signin_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PdfServices pdfServices = PdfServices();

  String? paymentMethod = 'cash';
  DateTime? selectedDate;
  TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);
  List<Map<String, dynamic>> treatments = [];

  // Method to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Method to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, signinProvider, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Column(
              children: [
                Container(
                  color: Pallete.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Pallete.textcolor,
                              ),
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
                                  top: 10,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Pallete.textfieldcordercolor,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: signinProvider.regformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field
                    Customfield(
                      hintText: "Enter Your Full Name",
                      label: 'Name',
                      controller: signinProvider.nameController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),

                    // WhatsApp Number Field
                    Customfield(
                      hintText: "Enter Your Whatsapp Number",
                      label: 'Whatsapp Number',
                      controller: signinProvider.wanumberController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),

                    // Address Field
                    Customfield(
                      hintText: "Enter Your Address",
                      label: 'Address',
                      controller: signinProvider.addressController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    // Location Dropdown Field
                    CustomDropDownField(
                      hintText: 'Select Your Location',
                      label: 'Location',
                      controller: signinProvider.locationController,
                      keyboardType: TextInputType.text,
                      selectedValue: signinProvider.selectedBranch,
                      items: const ['Location 1', 'Location 2', 'Location 3'],
                      onChanged: (newValue) {
                        setState(() {
                          signinProvider.selectedLocation = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    // Branch Dropdown Field
                    BranchDropdown(),

                    const SizedBox(height: 15),
                    //Treatment
                    TreatmentsWidget(
                      maleCount: int.tryParse(Provider.of<AppProvider>(context)
                              .malecoController
                              .text) ??
                          0,
                      femaleCount: int.tryParse(
                              Provider.of<AppProvider>(context)
                                  .femalecoController
                                  .text) ??
                          0,
                      title:
                          Provider.of<AppProvider>(context).selectedTreatment ??
                              'Couple Combo package i..',
                      malecoController:
                          Provider.of<AppProvider>(context).malecoController,
                      femalecoController:
                          Provider.of<AppProvider>(context).femalecoController,
                      onEditPressed: () {},
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomSolidButton(
                      text: '+ Add Treatments',
                      onPressed: () async {
                        // Show the PopUp and handle multiple treatments
                        var result = await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return PopUp();
                          },
                        );

                        // Check if we have a valid result
                        if (result != null) {
                          setState(() {
                            // Add the new treatment to the list
                            treatments.add({
                              'treatment': result['treatment'],
                              'maleCount': result['maleCount'],
                              'femaleCount': result['femaleCount'],
                            });
                          });
                        }
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    // Total Amount Field
                    Customfield(
                      hintText: "Enter Your total amount",
                      label: 'Total Amount',
                      controller: signinProvider.totalController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),

                    // Discount Amount Field
                    Customfield(
                      hintText: "Enter Your discount amount",
                      label: 'Discount Amount',
                      controller: signinProvider.branchController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    // Payment Method - Radio Buttons (Cash, Card, UPI)
                    Column(
                      children: [
                        Text(
                          'Payment Method',
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: 'cash',
                              groupValue: paymentMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  paymentMethod = value;
                                });
                              },
                            ),
                            Text(
                              'Cash',
                              style: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.formtextcolor,
                                    ),
                              ),
                            ),
                            Radio<String>(
                              value: 'card',
                              groupValue: paymentMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  paymentMethod = value;
                                });
                              },
                            ),
                            Text(
                              'Card',
                              style: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.formtextcolor,
                                    ),
                              ),
                            ),
                            Radio<String>(
                              value: 'upi',
                              groupValue: paymentMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  paymentMethod = value;
                                });
                              },
                            ),
                            Text(
                              'UPI',
                              style: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.formtextcolor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    //balance ammount field
                    Customfield(
                      hintText: "Enter Your Advance amount",
                      label: 'Advance Amount',
                      controller: signinProvider.advanceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //balance ammount field
                    Customfield(
                      hintText: "Enter Your Balance amount",
                      label: 'Balance Amount',
                      controller: signinProvider.balanceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Treatment Date Field (DatePicker)
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: Customfield(
                          hintText: selectedDate == null
                              ? "Select Treatment Date"
                              : "${selectedDate!.toLocal()}".split(' ')[0],
                          label: 'Treatment Date',
                          controller: signinProvider.dateController,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Treatment Time Field (TimePicker)
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: AbsorbPointer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Hour input field
                            Expanded(
                              child: Customfield(
                                hintText: selectedTime.hour
                                    .toString()
                                    .padLeft(2, '0'),
                                label: 'Hour',
                                controller: signinProvider.hourController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Minute input field
                            Expanded(
                              child: Customfield(
                                hintText: selectedTime.minute
                                    .toString()
                                    .padLeft(2, '0'),
                                label: 'Minute',
                                controller: signinProvider.minController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Balance Amount Field

                    CustomSolidButton(
                        text: 'Save',
                        onPressed: () async {
                          // if (signinProvider.signformKey.currentState
                          //         ?.validate() ??
                          //     false) {
                          //   signinProvider.register(context);
                          // }
                          final data = await pdfServices.generatePDF();

                          pdfServices.savePdfFile('Invoice_machinetest', data);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
