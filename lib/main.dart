import 'package:bloom_health_app/core/theme/theme.dart';
import 'package:bloom_health_app/features/auth/view/pages/sign_in_page.dart';
import 'package:bloom_health_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/bloom_dashboard_vm.dart';

import 'package:bloom_health_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const BloomHealthApp()));
}

class BloomHealthApp extends ConsumerWidget {
  const BloomHealthApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = BloomDashboardViewModel();
    final currentUser = ref.watch(authViewmodelProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloom',
      theme: AppTheme.lightTheme,
      // home: currentUser == null ? SignInPage() : BloomHomePage(viewModel: viewModel),
      home: BloomHomePage(viewModel: viewModel)
    );
  }
}
