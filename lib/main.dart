import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/features/login/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://btmwchwuyprqufskunzx.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0bXdjaHd1eXBycXVmc2t1bnp4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4NTc3ODQsImV4cCI6MjA0ODQzMzc4NH0.spND2gkWtrST3vrOuIQJoG0ORLHShpPG-JwnxFQBWBA');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}
