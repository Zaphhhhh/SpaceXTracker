import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_app/data/models/rocket.model.dart';

class RocketDetailsSection extends StatelessWidget {
  final Rocket rocket;

  const RocketDetailsSection({super.key, required this.rocket});

  Widget _buildDetailRow(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label : ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('d MMMM yyyy', 'fr_FR');
    final NumberFormat numberFormatter = NumberFormat.decimalPattern('fr_FR');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Détails de la Fusée :",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildDetailRow('Nom', rocket.name),
        _buildDetailRow('Type', rocket.type),
        _buildDetailRow('Entreprise', rocket.company),
        _buildDetailRow('Pays', rocket.country),
        if (rocket.firstFlight != null)
          _buildDetailRow(
            'Premier vol',
            dateFormatter.format(rocket.firstFlight!),
          ),
        if (rocket.successRatePct != null)
          _buildDetailRow('Taux de succès', '${rocket.successRatePct}%'),
        if (rocket.costPerLaunch != null)
          _buildDetailRow(
            'Coût par lancement',
            '\$${numberFormatter.format(rocket.costPerLaunch)}',
          ),
        if (rocket.height?.meters != null)
          _buildDetailRow('Hauteur', '${rocket.height!.meters} m'),
        if (rocket.diameter?.meters != null)
          _buildDetailRow('Diamètre', '${rocket.diameter!.meters} m'),
        if (rocket.mass?.kg != null)
          _buildDetailRow(
            'Masse',
            '${numberFormatter.format(rocket.mass!.kg)} kg',
          ),
      ],
    );
  }
}
