import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/utlit/Custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
          child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/regpage');
        },
        child: Text('Register page'),
      )),
    );
  }
}
