import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://yglnnkempumasoozkvhx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlnbG5ua2VtcHVtYXNvb3prdmh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE5MDY2NTgsImV4cCI6MjA0NzQ4MjY1OH0.s-qFPILtZZlLmtQeFKGiIwZQjTSMviPu_lCltqyWahc');
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perpustakaan',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}