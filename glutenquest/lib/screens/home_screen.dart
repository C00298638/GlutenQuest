
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'quiz_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color green = Color(0xFF23845B);

  late Future<String?> _profileNameFuture;

  @override
  void initState() {
    super.initState();
    _profileNameFuture = _loadProfileName();
  }

  Future<String?> _loadProfileName() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      return null;
    }

    final profile = await supabase
        .from('profiles')
        .select('full_name')
        .eq('id', user.id)
        .maybeSingle();

    return profile?['full_name'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GlutenQuest',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: green,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FutureBuilder<String?>(
            future: _profileNameFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text(
                  'Welcome to GlutenQuest!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  'Loading your profile...',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              final name = snapshot.data;

              return Text(
                name != null && name.isNotEmpty
                    ? 'Welcome, $name!'
                    : 'Welcome to GlutenQuest!',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn something new, one quiz at a time.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 24),

          // Player progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LEVEL 1',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('0 / 100 XP'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const LinearProgressIndicator(value: 0),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 6),
                      Text('0 day streak'),
                      Spacer(),
                      Icon(
                        Icons.emoji_events_outlined,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 6),
                      Text('0 badges'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Daily quiz
          Card(
            color: green,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.quiz_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'DAILY CHALLENGE',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Test your gluten-free knowledge!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Answer 5 questions and earn XP.',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuizScreen(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: green,
                      ),
                      child: const Text('START QUIZ'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Your journey',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Learn'),
            subtitle: const Text('Explore quiz topics'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.emoji_events_outlined),
            title: const Text('Achievements'),
            subtitle: const Text('Discover your badges'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.insights),
            title: const Text('My progress'),
            subtitle: const Text('Track your learning'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
