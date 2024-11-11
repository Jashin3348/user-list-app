import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list_app/providers/user_provider.dart';
import 'package:user_list_app/screens/user_list_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'User List App',
        debugShowCheckedModeBanner: false,
        home: UserListScreen());
  }
}
