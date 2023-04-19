import 'package:flutter/material.dart';

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
    return Consumer<GoogleSignInProvider>(
      builder: (BuildContext context, authProvider, Widget? child) {
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
                  child: authProvider.isAuthenticated
                      ? const TodosScreen()
                      : AnimatedSwitcher(
                          duration: const Duration(
                            seconds: 1,
                          ),
                          child: StreamBuilder(
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
                              } else {
                                return const SignInScreen(
                                  key: Key('signin'),
                                );
                              }
                            }),
                          ),
                        ),
                ),
                if (authProvider.isSigningIn)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
