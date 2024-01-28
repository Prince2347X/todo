import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todo/services/auth.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login.png',
                  ),
                  SizedBox(
                    width: width * 0.9,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 68.0, bottom: 16),
                          child: Text(
                            'Get things done with ToDo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            'Get organized with the easy-to-use app for managing your to-do list.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -width * 0.09,
              left: -height * 0.22,
              child: Container(
                height: height * 0.28,
                width: height * 0.28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 145, 98, 0.2),
                ),
              ),
            ),
            Positioned(
              left: -width * 0.09,
              top: -height * 0.22,
              child: Container(
                height: height * 0.28,
                width: height * 0.28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 145, 98, 0.2),
                ),
              ),
            ),
            Positioned(
              left: width * 0.18,
              right: width * 0.18,
              bottom: height * 0.08,
              height: 56,
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(
                    context,
                    listen: false,
                  );
                  provider.googleLogin();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34,
                      child: Image.asset(
                        'assets/images/google.png',
                      ),
                    ),
                    const Text(
                      '  Sign In',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
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
