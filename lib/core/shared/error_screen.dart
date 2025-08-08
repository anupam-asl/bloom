import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outlined, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error initializing app',
              style: TextTheme.of(context).headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('$error'),
          ],
        ),
      ),
    );
  }
}
