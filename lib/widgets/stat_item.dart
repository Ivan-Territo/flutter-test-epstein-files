/// Widget che mostra una statistica (valore + etichetta)
/// Usato nella sezione stats della homepage
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Widget per mostrare una singola statistica con valore e label
///
/// Esempio:
/// StatItem(value: '50+', label: 'Camere', isDesktop: true, isTablet: false)
class StatItem extends StatelessWidget {
  final String value; // Valore della statistica (es: "50+")
  final String label; // Etichetta della statistica (es: "Camere")
  final bool isDesktop; // Se il device è desktop
  final bool isTablet; // Se il device è tablet

  const StatItem({
    super.key,
    required this.value,
    required this.label,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Valore principale - grande e in grassetto
        Text(
          value,
          style: TextStyle(
            fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        // Spaziatura responsiva
        SizedBox(height: isDesktop ? 8 : 4),
        // Etichetta descrittiva
        Text(
          label,
          style: TextStyle(
            fontSize: isDesktop ? 14 : (isTablet ? 12 : 11),
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
