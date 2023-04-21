import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:todo/screens/signin.dart';
import 'package:todo/screens/todos.dart';
import 'package:todo/services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 400,
              ),
              transitionBuilder: (Widget widget, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.9),
                    end: Offset.zero,
                  ).animate(animation),
                  child: widget,
                );
              },
              child: Provider.of<GoogleSignInProvider>(context, listen: false).isAuthenticated
                    ? const TodosScreen()
                    : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              key: Key('loading'),
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              key: Key('error'),
                              child: Text('Something went wrong.'),
                            );
                          } else if (snapshot.hasData) {
                            return const TodosScreen(
                              key: Key('todos'),
                            );
                          } else {
                            return const SignInScreen(
                              key: Key('signin'),
                            );
                          }
                        }),
                      ),
              ),
            if (Provider.of<GoogleSignInProvider>(context, listen: false).isSigningIn)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
