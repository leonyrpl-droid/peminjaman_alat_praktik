import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(
    const InventarisApp(),
  );
}

class InventarisApp
    extends StatelessWidget {
  const InventarisApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false,

      title:
          'Inventaris Alat Praktik',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme:
            ColorScheme.fromSeed(
          seedColor:
              const Color(
            0xFF4F46E5,
          ),

          brightness:
              Brightness.light,
        ),

        scaffoldBackgroundColor:
            const Color(
          0xFFF5F7FC,
        ),

        appBarTheme:
            const AppBarTheme(
          elevation: 0,

          backgroundColor:
              Color(0xFF4F46E5),

          foregroundColor:
              Colors.white,
        ),
      ),

      home:
          const HomePage(),
    );
  }
}