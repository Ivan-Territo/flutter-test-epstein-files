import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HotelPage(),
    );
  }
}

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int? _hoveredCardIndex;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Animazione fade-in per le card
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> rooms = const [
    {
      'nome': 'Camera Matrimoniale',
      'tipologia': 'Standard',
      'prezzo': 100.0,
      'posti': 2,
      'servizi': ['Wi-Fi', 'A/C'],
      'immagine': 'assets/img/pexels-digitalbuggu-167533.jpg',
    },
    {
      'nome': 'Suite Vista Mare',
      'tipologia': 'Deluxe',
      'prezzo': 185.0,
      'posti': 2,
      'servizi': ['Wi-Fi', 'A/C', 'Minibar'],
      'immagine': 'assets/img/pexels-didi-lecatompessy-2149441489-33125906.jpg',
    },
    {
      'nome': 'Camera Doppia Classic',
      'tipologia': 'Standard',
      'prezzo': 120.0,
      'posti': 2,
      'servizi': ['Wi-Fi', 'TV'],
      'immagine': 'assets/img/pexels-digitalbuggu-167533.jpg',
    },
    {
      'nome': 'Junior Suite',
      'tipologia': 'Superior',
      'prezzo': 150.0,
      'posti': 3,
      'servizi': ['Wi-Fi', 'A/C', 'Balcone'],
      'immagine': 'assets/img/pexels-didi-lecatompessy-2149441489-33125906.jpg',
    },
    {
      'nome': 'Camera Singola',
      'tipologia': 'Economy',
      'prezzo': 75.0,
      'posti': 1,
      'servizi': ['Wi-Fi'],
      'immagine': 'assets/img/pexels-digitalbuggu-167533.jpg',
    },
    {
      'nome': 'Suite Presidenziale',
      'tipologia': 'Luxury',
      'prezzo': 350.0,
      'posti': 4,
      'servizi': ['Wi-Fi', 'A/C', 'Minibar', 'Jacuzzi'],
      'immagine': 'assets/img/pexels-didi-lecatompessy-2149441489-33125906.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    int crossAxisCount = 2;
    if (isTablet) crossAxisCount = 3;
    if (isDesktop) crossAxisCount = 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Hotel'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con titolo e search
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
                  Text(
                    'Dream Hotels',
                    style: TextStyle(
                      fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cerca camere...',
                      prefixIcon: const Icon(Icons.search, color: Colors.teal),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isDesktop ? 16 : 12,
                        horizontal: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            // Hero Section
            Container(
              height: isDesktop ? 300 : (isTablet ? 250 : 200),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.teal.shade300],
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
                      Text(
                        'Secure Your Dream Vacation',
                        style: TextStyle(
                          fontSize: isDesktop ? 36 : (isTablet ? 28 : 24),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'with a Reservation',
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : (isTablet ? 20 : 18),
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: isDesktop ? 32 : 16),
            // Stats Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('121+', 'Choices', isDesktop, isTablet),
                  _buildStatItem('80+', 'Restaurants', isDesktop, isTablet),
                  _buildStatItem('1K+', 'Happy Visitors', isDesktop, isTablet),
                ],
              ),
            ),
            SizedBox(height: isDesktop ? 40 : 24),
            // Title Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
              child: Text(
                'Our top-rated and highly visited hotel',
                style: TextStyle(
                  fontSize: isDesktop ? 28 : (isTablet ? 24 : 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: isDesktop ? 24 : 16),
            // Rooms Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isDesktop ? 20 : 12,
                  mainAxisSpacing: isDesktop ? 20 : 12,
                  childAspectRatio: isDesktop ? 0.85 : 0.75,
                ),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return _buildRoomCard(room, isDesktop, isTablet, index);
                },
              ),
            ),
            SizedBox(height: isDesktop ? 48 : 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCard(
    Map<String, dynamic> room,
    bool isDesktop,
    bool isTablet,
    int index,
  ) {
    final imageHeight = isDesktop ? 180.0 : (isTablet ? 150.0 : 120.0);
    final titleSize = isDesktop ? 18.0 : (isTablet ? 16.0 : 14.0);
    final subtitleSize = isDesktop ? 14.0 : (isTablet ? 13.0 : 12.0);
    final priceSize = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);
    final chipSize = isDesktop ? 12.0 : (isTablet ? 11.0 : 10.0);

    final isHovered = _hoveredCardIndex == index;
    final scale = isHovered ? 1.08 : 1.0;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
        ),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                setState(() {
                  _hoveredCardIndex = index;
                });
              },
              onExit: (_) {
                setState(() {
                  _hoveredCardIndex = null;
                });
              },
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${room['nome']} - €${room['prezzo']}/notte',
                      ),
                      duration: const Duration(milliseconds: 1500),
                    ),
                  );
                },
                child: Card(
                  elevation: isHovered ? 12 : 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(isDesktop ? 16 : 12),
                        ),
                        child: Image.asset(
                          room['immagine'],
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room['nome'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: isDesktop ? 6 : 4),
                            Text(
                              room['tipologia'],
                              style: TextStyle(
                                fontSize: subtitleSize,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: isDesktop ? 8 : 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.euro,
                                  size: isDesktop ? 18 : (isTablet ? 16 : 14),
                                  color: Colors.teal,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${room['prezzo']}/notte',
                                  style: TextStyle(
                                    fontSize: priceSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: isDesktop ? 8 : 4),
                            Wrap(
                              spacing: isDesktop ? 6 : 4,
                              runSpacing: 4,
                              children: (room['servizi'] as List<String>)
                                  .take(isDesktop ? 3 : 2)
                                  .map(
                                    (servizio) => Chip(
                                      label: Text(
                                        servizio,
                                        style: TextStyle(fontSize: chipSize),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isDesktop ? 8 : 4,
                                        vertical: 0,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
