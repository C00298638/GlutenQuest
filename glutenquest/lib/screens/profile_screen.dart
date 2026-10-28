
import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF146B3A);
    const lightGreen = Color(0xFFE8F5E9);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              // Profile avatar
              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    color: lightGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 65,
                    color: darkGreen,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Your Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Manage your GlutenQuest account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 32),

              // Placeholder profile information
              _profileInfo(
                icon: Icons.person_outline,
                label: 'Name',
                value: 'Guest User',
              ),

              const SizedBox(height: 14),

              _profileInfo(
                icon: Icons.email_outlined,
                label: 'Email',
                value: 'Not connected yet',
              ),

              const SizedBox(height: 14),

              _profileInfo(
                icon: Icons.emoji_events_outlined,
                label: 'Total points',
                value: '0 points',
              ),

              const SizedBox(height: 14),

              _profileInfo(
                icon: Icons.quiz_outlined,
                label: 'Quizzes completed',
                value: '0 quizzes',
              ),

              const SizedBox(height: 32),

              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Profile editing will be added later.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profile'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: darkGreen,
                  side: const BorderSide(color: darkGreen),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    const darkGreen = Color(0xFF146B3A);
    const lightGreen = Color(0xFFE8F5E9);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreen.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE8DE)),
      ),
      child: Row(
        children: [
          Icon(icon, color: darkGreen, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
