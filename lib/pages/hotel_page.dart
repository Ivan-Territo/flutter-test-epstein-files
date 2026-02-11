/// Pagina principale dell'hotel - visualizza tutte le camere con filtro di ricerca
/// Contiene: header con search, hero section, statistiche, grid di camere
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/rooms_data.dart';
import '../widgets/room_card.dart';
import '../widgets/stat_item.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> with TickerProviderStateMixin {
  // Controller per il campo di ricerca
  late TextEditingController _searchController;

  // Controller e animation per l'effetto fade-in delle card all'apertura
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Traccia quale card è in hover (per l'effetto scala)
  int? _hoveredCardIndex;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // SETUP ANIMAZIONE FADE-IN
    // Crea un'animazione che fade-in tutte le card quando la pagina si carica
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Tween da 0 (invisibile) a 1 (visibile) con curva easeIn
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Avvia l'animazione
    _fadeController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CALCOLO RESPONSIVO: determina il tipo di device
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    // Numero di colonne della grid basato sul device
    int crossAxisCount = 2; // Mobile: 2 colonne
    if (isTablet) crossAxisCount = 3; // Tablet: 3 colonne
    if (isDesktop) crossAxisCount = 4; // Desktop: 4 colonne

    return Scaffold(
      // APPBAR con titolo
      appBar: AppBar(
        title: const Text(
          'Dream Hotel',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEZIONE 1: HEADER CON TITOLO E SEARCH
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                isDesktop ? 48 : 16,
                16,
                isDesktop ? 48 : 16,
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Benvenuto" - sottotitolo
                  Text(
                    'Benvenuto',
                    style: TextStyle(
                      fontSize: isDesktop ? 14 : 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  // Titolo principale
                  Text(
                    'Trova la tua camera perfetta',
                    style: TextStyle(
                      fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // CAMPO RICERCA
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cerca camere...',
                      prefixIcon: const Icon(Icons.search, color: primaryColor),
                      // Bottone clear dinamico - appare solo se c'è testo
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300] ?? Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300] ?? Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isDesktop ? 16 : 12,
                        horizontal: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
                        color: Colors.grey[400],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {}); // Rigenera il widget al cambio testo
                    },
                  ),
                ],
              ),
            ),

            // SEZIONE 2: HERO SECTION - Banner con gradiente
            Container(
              height: isDesktop ? 300 : (isTablet ? 250 : 200),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Titolo principale del banner
                      Text(
                        'Vivi un\nEsperienza Indimenticabile',
                        style: TextStyle(
                          fontSize: isDesktop ? 36 : (isTablet ? 28 : 24),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Sottotitolo
                      Text(
                        'Scegli tra le nostre camere di lusso',
                        style: TextStyle(
                          fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: isDesktop ? 32 : 16),

            // SEZIONE 3: STATISTICHE - Tre card con numeri
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatItem(
                    value: '50+',
                    label: 'Camere',
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                  ),
                  StatItem(
                    value: '4.8★',
                    label: 'Valutazione',
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                  ),
                  StatItem(
                    value: '1K+',
                    label: 'Ospiti Felici',
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),

            SizedBox(height: isDesktop ? 40 : 24),

            // SEZIONE 4: TITOLO DELLA SEZIONE CAMERE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titolo principale
                  Text(
                    'Le nostre camere più apprezzate',
                    style: TextStyle(
                      fontSize: isDesktop ? 28 : (isTablet ? 24 : 20),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Sottotitolo
                  Text(
                    'Selezionato dai nostri ospiti',
                    style: TextStyle(
                      fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isDesktop ? 24 : 16),

            // SEZIONE 5: GRID DI CAMERE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isDesktop ? 20 : 12,
                  mainAxisSpacing: isDesktop ? 20 : 12,
                  // Aspect ratio per determinare l'altezza delle card
                  childAspectRatio: isDesktop ? 1.1 : (isTablet ? 0.9 : 0.75),
                ),
                itemCount: roomsList.length,
                itemBuilder: (context, index) {
                  return RoomCard(
                    room: roomsList[index],
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    index: index,
                    fadeController: _fadeController,
                    fadeAnimation: _fadeAnimation,
                    isHovered: _hoveredCardIndex == index,
                    onHoverChange: (index) {
                      setState(() {
                        _hoveredCardIndex = index;
                      });
                    },
                  );
                },
              ),
            ),

            SizedBox(height: isDesktop ? 48 : 24),
          ],
        ),
      ),
    );
  }
}
