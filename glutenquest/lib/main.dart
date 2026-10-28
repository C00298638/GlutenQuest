
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zbpsknmncedodfxvozts.supabase.co', // Replace with your Supabase URL
    publishableKey: 'sb_publishable_2ApAmKsx2wJrxs-Mn0OAwA_c3Lll9JT',
   );
   runApp(const GlutenQuestApp());
}

class GlutenQuestApp extends StatelessWidget {
  const GlutenQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlutenQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF23845B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F5),
      ),
      home: const LoginScreen(),
    );
  }
}
