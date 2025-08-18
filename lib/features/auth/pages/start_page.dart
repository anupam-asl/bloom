import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:bloom_health_app/core/services/auth_service.dart';
import 'package:bloom_health_app/features/auth/entities/session.dart';
import 'package:bloom_health_app/features/auth/pages/home_page.dart';
import 'package:bloom_health_app/features/auth/widgets/auth_button.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool _appleAvailable = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _checkAppleAvailability();
  }

  Future<void> _checkAppleAvailability() async {
    final available = await SignInWithApple.isAvailable();
    setState(() => _appleAvailable = available);
  }

  // Future<void> _handleGoogle() async {
  //   setState(() => _loading = true);
  //   final session = await AuthService.signInWithGoogle();
  //   setState(() => _loading = false);
  //   if (session != null && mounted) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(session: session)));
  //   }
  // }
  Future<void> _handleGoogle() async {
  setState(() => _loading = true);
  try {
    final session = await AuthService.signInWithGoogle();
    setState(() => _loading = false);

    if (session != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(session: session)),
      );
    }
  } catch (e) {
    setState(() => _loading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // e.toString().replaceFirst('Exception: ', ''),
            'Google sign-in failed. Please try again.',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  Future<void> _handleApple() async {
    setState(() => _loading = true);
    final session = await AuthService.signInWithApple();
    setState(() => _loading = false);
    if (session != null && mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(session: session)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFF7B61FF);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text("Let's get you started", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Email',
                  //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
                  //     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: purple,
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text('Continue', style: TextStyle(color: Colors.white)),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Row(children: const [
                  //   Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('OR')), Expanded(child: Divider())
                  // ]),
                  const SizedBox(height: 20),
                  AuthButton(
                    icon: Image.asset('assets/images/icons/google.png', width: 22, height: 22),
                    label: 'Sign up with Google',
                    onPressed: _handleGoogle,
                  ),
                  const SizedBox(height: 10),
                  // if (_appleAvailable)
                  //   AuthButton(
                  //     icon: const Icon(Icons.apple, size: 22),
                  //     label: 'Sign up with Apple',
                  //     onPressed: _handleApple,
                  //   ),
                  const Spacer(),
                  const Text(
                    'By signing in, you accept our Terms of Use and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ),
            if (_loading) const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
