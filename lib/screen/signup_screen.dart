import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jb_store/screen/form_signup_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup to JB STORE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle Google signup
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 45, 42, 42),
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                side:
                    const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/google.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Signup with Google',
                        style:
                            TextStyle(color: Color.fromARGB(255, 45, 42, 42)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Facebook signup
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 57, 53, 53),
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                side:
                    const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/facebook.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Signup with Facebook',
                        style:
                            TextStyle(color: Color.fromARGB(255, 57, 53, 53)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailSignupScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Signup with Email'),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Navigate to login screen
              },
              child: const Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
