import 'package:flutter/material.dart';
import 'package:bloom_health_app/features/auth/entities/session.dart';
import 'package:bloom_health_app/core/services/auth_service.dart';
import 'package:bloom_health_app/features/auth/pages/start_page.dart';

class HomePage extends StatelessWidget {
  final Session session;
  const HomePage({super.key, required this.session});

  Future<void> _logout(BuildContext context) async {
    await AuthService.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const StartPage()), (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloom Health App'), actions: [
        IconButton(onPressed: () => _logout(context), icon: const Icon(Icons.logout))
      ]),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (session.photoUrl != null)
            CircleAvatar(radius: 38, backgroundImage: NetworkImage(session.photoUrl!))
          else
            const CircleAvatar(radius: 38, child: Icon(Icons.person)),
          const SizedBox(height: 10),
          Text(session.name ?? 'User', style: const TextStyle(fontSize: 20)),
          Text(session.email ?? '', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Text('Signed in with: ${session.provider}'),
        ]),
      ),
    );
  }
}
