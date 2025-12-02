import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowcaseMenuPage extends StatelessWidget {
  const ShowcaseMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Kit')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MenuCard(
            title: 'Login Screen',
            subtitle: 'LoginForm',
            icon: Icons.login,
            onTap: () => context.push('/login'),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Register Screen',
            subtitle: 'RegisterForm',
            icon: Icons.person_add,
            onTap: () => context.push('/register'),
          ),
          const SizedBox(height: 16),
          _MenuCard(
            title: 'Dashboard Screen',
            subtitle: 'Dashboard',
            icon: Icons.dashboard,
            onTap: () => context.push('/dashboard'),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
