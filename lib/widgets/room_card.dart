/// Card interattiva che mostra i dettagli di una camera hotel
/// Include immagine, tipologia, nome, prezzo, servizi e bottone prenota
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Widget che rappresenta una singola camera con tutti i suoi dettagli
/// Include animazioni di fade-in, hover effect e interattività
class RoomCard extends StatefulWidget {
  final Map<String, dynamic> room;
  final bool isDesktop;
  final bool isTablet;
  final int index;
  final AnimationController fadeController;
  final Animation<double> fadeAnimation;
  final bool isHovered;
  final Function(int?) onHoverChange;

  const RoomCard({
    super.key,
    required this.room,
    required this.isDesktop,
    required this.isTablet,
    required this.index,
    required this.fadeController,
    required this.fadeAnimation,
    required this.isHovered,
    required this.onHoverChange,
  });

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    // Calcolo dimensioni responsivi per immagine e testo
    final imageHeight = widget.isDesktop
        ? 180.0
        : (widget.isTablet ? 140.0 : 100.0);
    final titleSize = widget.isDesktop ? 18.0 : (widget.isTablet ? 16.0 : 13.0);
    final subtitleSize = widget.isDesktop
        ? 14.0
        : (widget.isTablet ? 13.0 : 11.0);
    final priceSize = widget.isDesktop ? 16.0 : (widget.isTablet ? 14.0 : 11.0);
    final chipSize = widget.isDesktop ? 12.0 : (widget.isTablet ? 11.0 : 9.0);

    // Scala del card al hover (1.08 = 8% più grande)
    final scale = widget.isHovered ? 1.08 : 1.0;

    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
          CurvedAnimation(parent: widget.fadeController, curve: Curves.easeOut),
        ),
        // AnimatedScale per effetto zoom al hover
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            // MouseRegion per gestire hover su desktop
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                widget.onHoverChange(widget.index);
              },
              onExit: (_) {
                widget.onHoverChange(null);
              },
              // GestureDetector per gestire tap
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.room['nome']} - €${widget.room['prezzo']}/notte',
                      ),
                      duration: const Duration(milliseconds: 1500),
                      backgroundColor: primaryColor,
                    ),
                  );
                },
                // Card principale con ombra responsiva
                child: Card(
                  elevation: widget.isHovered ? 12 : 4,
                  shadowColor: primaryColor.withOpacity(transparentOpacity),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      widget.isDesktop ? 16 : 12,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMMAGINE E BADGE TIPOLOGIA
                      Stack(
                        children: [
                          // Immagine della camera
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(widget.isDesktop ? 16 : 12),
                            ),
                            child: Image.asset(
                              widget.room['immagine'],
                              height: imageHeight,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Badge con la tipologia (Standard, Deluxe, ecc)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      shadowOpacity,
                                    ),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Text(
                                widget.room['tipologia'],
                                style: TextStyle(
                                  fontSize: chipSize,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // CONTENUTO CARD - Expanded con scroll per evitare overflow
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(
                              widget.isDesktop
                                  ? 16.0
                                  : (widget.isTablet ? 12.0 : 6.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nome camera con stella
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.room['nome'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: titleSize,
                                          color: Colors.grey[800],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: starColor,
                                      size: widget.isDesktop ? 20 : 16,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget.isDesktop
                                      ? 8
                                      : (widget.isTablet ? 4 : 2),
                                ),
                                // Numero di posti letto
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bed_rounded,
                                      size: widget.isDesktop ? 16 : 12,
                                      color: Colors.grey[500],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${widget.room['posti']} ${widget.room['posti'] == 1 ? 'posto' : 'posti'}',
                                      style: TextStyle(
                                        fontSize: subtitleSize,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget.isDesktop
                                      ? 12
                                      : (widget.isTablet ? 6 : 3),
                                ),
                                // Prezzo per notte
                                Row(
                                  children: [
                                    Icon(
                                      Icons.euro_rounded,
                                      size: widget.isDesktop ? 18 : 14,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${widget.room['prezzo']}',
                                      style: TextStyle(
                                        fontSize: priceSize,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      '/notte',
                                      style: TextStyle(
                                        fontSize: priceSize - 2,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget.isDesktop
                                      ? 10
                                      : (widget.isTablet ? 4 : 3),
                                ),
                                // Chip con i servizi disponibili (Wi-Fi, A/C, ecc)
                                Wrap(
                                  spacing: widget.isDesktop ? 6 : 4,
                                  runSpacing: 4,
                                  children:
                                      (widget.room['servizi'] as List<String>)
                                          .take(widget.isDesktop ? 3 : 2)
                                          .map(
                                            (servizio) => Chip(
                                              label: Text(
                                                servizio,
                                                style: TextStyle(
                                                  fontSize: chipSize,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: widget.isDesktop
                                                    ? 8
                                                    : 4,
                                                vertical: 0,
                                              ),
                                              backgroundColor: primaryColor
                                                  .withOpacity(0.1),
                                              side: BorderSide(
                                                color: primaryColor.withOpacity(
                                                  0.2,
                                                ),
                                              ),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          )
                                          .toList(),
                                ),
                                SizedBox(
                                  height: widget.isDesktop
                                      ? 12
                                      : (widget.isTablet ? 6 : 4),
                                ),
                                // Bottone Prenota
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Prenotazione ${widget.room['nome']} richiesta!',
                                          ),
                                          backgroundColor: primaryColor,
                                          duration: const Duration(seconds: 2),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            textColor: whiteColor,
                                            onPressed: () {},
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: whiteColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: widget.isDesktop
                                            ? 12
                                            : (widget.isTablet ? 10 : 6),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Prenota',
                                      style: TextStyle(
                                        fontSize: widget.isDesktop ? 14 : 10,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
