import 'package:bloom_health_app/core/theme/theme.dart';
import 'package:bloom_health_app/features/auth/view/pages/sign_in_page.dart';
import 'package:bloom_health_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';
import 'package:bloom_health_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/db/app_database.dart';
import 'core/db/database_provider.dart';
import 'features/bloom/presentation/viewmodels/glucose_providers.dart'; // your new providers

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await LocalDatabase.database; // Creates DB if not exists

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ProviderScope(
      overrides: [
        // Provide the actual database instance to the provider
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
    final currentUser = ref.watch(authViewmodelProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloom',
      theme: AppTheme.lightTheme,
      home:const BloomHomePage(),
      // home: currentUser == null
      //     ? const SignInPage()
      //     : const BloomHomePage(), // No manual ViewModel passing now
    );
  }
}
