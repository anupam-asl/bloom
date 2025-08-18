import 'package:bloom_health_app/core/theme/theme.dart';
import 'package:bloom_health_app/core/db/app_database.dart';
import 'package:bloom_health_app/core/db/database_provider.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';
import 'package:bloom_health_app/features/auth/entities/session.dart';
import 'package:bloom_health_app/core/services/storage_service.dart';
import 'package:bloom_health_app/features/auth/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await LocalDatabase.database; // init DB

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
      child: const BloomHealthApp(),
    ),
  );
}

class BloomHealthApp extends ConsumerWidget {
  const BloomHealthApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloom',
      theme: AppTheme.lightTheme,
      home: FutureBuilder<Session?>(
        future: StorageService.loadSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data != null) {
            return BloomHomePage(session: snapshot.data!);
          } else {
            return const StartPage();
          }
        },
      ),
    );
  }
}
