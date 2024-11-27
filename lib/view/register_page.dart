import 'package:ayurvedic_centre_patients/utlit/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/utlit/common_widget.dart';
import 'package:ayurvedic_centre_patients/provider/signin_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? paymentMethod = 'cash'; // Default payment method
  DateTime? selectedDate;
  TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);

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
                  children: [
                    // Name Field
                    CommonWidget(
                      hintText: "Enter Your Full Name",
                      label: 'Name',
                      controller: signinProvider.nameController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),

                    // WhatsApp Number Field
                    CommonWidget(
                      hintText: "Enter Your Whatsapp Number",
                      label: 'Whatsapp Number',
                      controller: signinProvider.wanumberController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),

                    // Address Field
                    CommonWidget(
                      hintText: "Enter Your Address",
                      label: 'Address',
                      controller: signinProvider.addressController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    // Branch Dropdown Field
                    CommonWidget(
                      hintText: "Select Your Branch",
                      label: 'Branch',
                      controller: signinProvider.branchController,
                      keyboardType: TextInputType.text,
                      child: DropdownButtonFormField<String>(
                        value: signinProvider.selectedBranch,
                        onChanged: (String? newValue) {
                          setState(() {
                            signinProvider.selectedBranch = newValue;
                          });
                        },
                        items: <String>['Branch 1', 'Branch 2', 'Branch 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Branch',
                          hintText: 'Select your branch',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Location Dropdown Field
                    CommonWidget(
                      hintText: "Select Your Location",
                      label: 'Location',
                      controller: signinProvider.locationController,
                      keyboardType: TextInputType.text,
                      child: DropdownButtonFormField<String>(
                        value: signinProvider.selectedLocation,
                        onChanged: (String? newValue) {
                          setState(() {
                            signinProvider.selectedLocation = newValue;
                          });
                        },
                        items: <String>[
                          'Location 1',
                          'Location 2',
                          'Location 3'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          hintText: 'Select your location',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                    // Total Amount Field
                    CommonWidget(
                      hintText: "Enter Your total amount",
                      label: 'Total Amount',
                      controller: signinProvider.totalController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),

                    // Discount Amount Field
                    CommonWidget(
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
                    CommonWidget(
                      hintText: "Enter Your Advance amount",
                      label: 'Advance Amount',
                      controller: signinProvider.advanceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //balance ammount field
                    CommonWidget(
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
                        child: CommonWidget(
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
                              child: CommonWidget(
                                hintText:
                                    "${selectedTime.hour.toString().padLeft(2, '0')}",
                                label: 'Hour',
                                controller: signinProvider.hourController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Minute input field
                            Expanded(
                              child: CommonWidget(
                                hintText:
                                    "${selectedTime.minute.toString().padLeft(2, '0')}",
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
                      onPressed: () {
                        if (signinProvider.signformKey.currentState
                                ?.validate() ??
                            false) {
                          signinProvider.register(context);
                        }
                      },
                    ),
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
