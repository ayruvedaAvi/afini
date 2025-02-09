import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String? errorMessage;
  const ErrorScreen({super.key, this.errorMessage});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'It seems like the page you were looking for doesn\'t exist or there was an error loading it.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (widget.errorMessage != null)
              Text(
                'Error Details: ${widget.errorMessage}',
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
