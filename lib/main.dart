import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:read_cache_ui/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ReadCache());
}

class ReadCache extends StatelessWidget {
  const ReadCache({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
