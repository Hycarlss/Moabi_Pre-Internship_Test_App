// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/event_provider.dart';

import 'core/routes/app_router.dart';

import 'core/services/local_storage_service.dart';
import 'core/services/ecc_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.init();

  final eventProvider =
      EventProvider();

  await eventProvider.loadEvents();

  // ECC KEY GENERATION
  final keyPair =
      ECCService.generateKeyPair();

  print(
    'ECC Key Pair Generated Successfully',
  );

  print(keyPair.publicKey);

  runApp(
    ChangeNotifierProvider.value(
      value: eventProvider,

      child: const FigmaToCodeApp(),
    ),
  );
}

class FigmaToCodeApp
    extends StatelessWidget {
  const FigmaToCodeApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner:
          false,

      title: 'Moabi Event Manager',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
            const Color(0xFFF0F9FF),

        colorScheme:
            ColorScheme.fromSeed(
          seedColor:
              const Color(0xFF3B82F6),
        ),
      ),

      routerConfig: appRouter,
    );
  }
}