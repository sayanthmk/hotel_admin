// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hotel_admin/constants/colors/colors.dart';
import 'package:hotel_admin/view/auth/signup_page/sign_up_form.dart';
import 'package:hotel_admin/view/main_page/drawer.dart';
import 'package:hotel_admin/widgets/auth_widgets/gradiant_button.dart';
import 'package:hotel_admin/widgets/auth_widgets/textfrom_field.dart';
import 'package:hotel_admin/widgets/auth_widgets/bottom_text_row.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_admin/controller/auth_service/auth_service.dart';

class CustomAdmiLogin extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  CustomAdmiLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'WELCOME BACK',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome back! Please enter your details.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: emailController,
                  labelText: 'Enter your email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  borderColor: Colors.grey,
                  focusedBorderColor: AdminColors.primerybuttoncolor,
                  enabledBorderColor: Colors.grey,
                  errorBorderColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  borderColor: Colors.grey,
                  focusedBorderColor: AdminColors.primerybuttoncolor,
                  enabledBorderColor: Colors.grey,
                  errorBorderColor: Colors.red,
                  obscureText: true,
                  suffixIcon: const Icon(Icons.remove_red_eye),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Sign in",
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await authService.signInWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const DrawerSample(),
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to sign in: ${e.toString()}')),
                    );
                  }
                }
              },
              color: const Color.fromARGB(255, 78, 37, 241),
              textColor: Colors.white,
              borderRadius: 10.0,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              fontSize: 18.0,
              fontWeight: FontWeight.w200,
              height: 50,
              width: 400,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Sign in with Google",
              onTap: () async {
                await authService.signInWithGoogle();
              },
              color: Colors.white,
              textColor: Colors.grey,
              borderRadius: 10.0,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: double.infinity,
              icon: FontAwesomeIcons.google,
            ),
            const SizedBox(height: 20),
            SignInRow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              signInText: 'Sign Up',
              promptText: "Don't have an account? ",
              signInTextColor: const Color.fromARGB(255, 78, 37, 241),
            ),
          ],
        ),
      ),
    );
  }
}
