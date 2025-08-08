import 'package:bloom_health_app/core/utils.dart';
import 'package:bloom_health_app/core/widgets/loader.dart';
import 'package:bloom_health_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/bloom_dashboard_vm.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = BloomDashboardViewModel();
    final isLoading = ref.watch(
      authViewmodelProvider.select((value) => value?.isLoading == true),
    );

    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
        data: (data) {
          if (data != null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BloomHomePage(viewModel: viewModel)),
                  (_) => false,
            );
          }
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });


    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Loader()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please sign in to continue.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(authViewmodelProvider.notifier)
                          .signInWithGoogle();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
