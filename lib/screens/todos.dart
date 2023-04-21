import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:todo/components/avatar.dart';
import 'package:todo/components/todo_list_view.dart';
import 'package:todo/services/auth.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabBarController;
  late TextEditingController _todoTextController;

  @override
  void initState() {
    _tabBarController = TabController(
      length: 2,
      vsync: this,
    );
    _todoTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    _todoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(8),
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 8),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: IconButton(
                    splashRadius: 32,
                    color: Colors.white,
                    splashColor: Theme.of(context).scaffoldBackgroundColor,
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                        context,
                        listen: false,
                      );
                      provider.logout();
                    },
                  ),
                ),
                Positioned(
                  bottom: -48,
                  left: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAvatar(user: user),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Hey, ${user.displayName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            <Widget>[
              const TodoListView(
                key: Key('active'),
                isCompleted: false,
              ),
              const TodoListView(
                key: Key('completed'),
                isCompleted: true,
              ),
            ].elementAt(_currentIndex)
          ],
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: const [
              Tab(
                child: Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'COMPLETED',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            splashFactory: NoSplash.splashFactory,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black.withOpacity(0.5),
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).primaryColor,
            controller: _tabBarController,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          backgroundColor: Colors.white,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                            bottom: 8,
                          ),
                          child: TextField(
                            autofocus: true,
                            controller: _todoTextController,
                            decoration: const InputDecoration(hintText: 'New todo'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          onPressed: () {
                            if (_todoTextController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Are you trying to procrastinate by adding an empty ToDo?',
                                  ),
                                ),
                              );
                              return;
                            }
                            //TODO: Add todo to firestore
                            Navigator.pop(context);
                            _todoTextController.clear();
                          },
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
            size: 36,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
