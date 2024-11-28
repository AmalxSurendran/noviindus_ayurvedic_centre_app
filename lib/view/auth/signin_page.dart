import 'package:ayurvedic_centre_patients/utlit/customfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ayurvedic_centre_patients/utlit/Custom_button.dart';
import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/provider/signin_provider.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, signinProvider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: signinProvider.signformKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 217,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/signin.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/signin2.png',
                            width: 80,
                            height: 84,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login or register to book your appointments',
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      height: 36 / 24,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email TextField
                        Customfield(
                          label: 'Email',
                          hintText: 'Email',
                          controller: signinProvider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              signinProvider.validateEmail(value!),
                        ),
                        const SizedBox(height: 15),
                        // Password TextField
                        Customfield(
                          label: 'Password',
                          hintText: 'Password',
                          controller: signinProvider.passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: signinProvider.isPasswordVisible,
                          suffixIcon: InkWell(
                            onTap: signinProvider.togglePasswordVisibility,
                            child: Icon(
                              signinProvider.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Pallete.textcolor,
                            ),
                          ),
                          validator: (value) =>
                              signinProvider.validatePassword(value!),
                        ),
                        const SizedBox(height: 50),
                        CustomSolidButton(
                          text: 'Login',
                          onPressed: () {
                            if (signinProvider.signformKey.currentState
                                    ?.validate() ??
                                false) {
                              signinProvider.login(context);
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text:
                                    'By creating or logging into an account you are agreeing with our ',
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ),
                              TextSpan(
                                text: 'Terms and Conditions ',
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Pallete.termstext),
                                ),
                              ),
                              TextSpan(
                                text: 'and ',
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Pallete.termstext),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10), // Added space at the bottom
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
