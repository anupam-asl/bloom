import 'package:bloom_health_app/core/theme/theme.dart';
import 'package:bloom_health_app/core/db/app_database.dart';
import 'package:bloom_health_app/core/db/database_provider.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';
import 'package:bloom_health_app/features/auth/entities/session.dart';
import 'package:bloom_health_app/core/services/storage_service.dart';
import 'package:bloom_health_app/features/auth/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return ScreenUtilInit(
      // 👇 set your Figma design size here
      designSize: const Size(402, 874), // Example: iPhone 13 size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bloom',
          theme: AppTheme.lightTheme,
          home: child,
        );
      },
      child: FutureBuilder<Session?>(
        future: StorageService.loadSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data != null) {
            // return BloomHomePage(session: snapshot.data!);
            return BloomSplashScreen();
          } else {
            // return const StartPage();
            return BloomSplashScreen();
          }
        },
      ),
    );
  }
}
