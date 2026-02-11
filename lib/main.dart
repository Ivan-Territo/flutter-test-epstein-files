/// Entry point dell'applicazione Dream Hotel
/// Configura il tema e inizializza l'app
import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'pages/hotel_page.dart';

void main() {
  runApp(const MyApp());
}

/// Widget radice dell'applicazione
/// Configura il tema MaterialApp e il home page
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titolo dell'app
      title: 'Dream Hotel',

      // CONFIGURAZIONE TEMA GLOBALE
      theme: ThemeData(
        // Colore primario del tema basato su primaryColor
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),

        // Abilita Material Design 3
        useMaterial3: true,

        // Font globale
        fontFamily: 'Roboto',

        // Stile AppBar personalizzato
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0, // Senza ombra
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),

      // Home page iniziale
      home: const HotelPage(),
    );
  }
}
