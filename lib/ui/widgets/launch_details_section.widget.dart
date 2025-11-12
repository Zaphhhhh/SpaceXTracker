import 'package:flutter/material.dart';
import 'package:spacex_app/data/models/launch.model.dart';
import 'package:spacex_app/utils/date_formatter.dart';

class LaunchDetailsSection extends StatelessWidget {
  final Launch launch;

  const LaunchDetailsSection({super.key, required this.launch});

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
    final failureReasons = launch.failures
        ?.map((failure) => "- ${failure.reason}")
        .join('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Détails du Vol :",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildDetailRow(
          'Date exacte (UTC)',
          DateFormatter().formatDateManually(launch.dateUtc),
        ),
        _buildDetailRow('ID de la fusée', launch.rocket),
        _buildDetailRow('ID du lancement', launch.id),
        if (failureReasons != null && failureReasons.isNotEmpty)
          _buildDetailRow('Raisons de l\'échec', failureReasons),
      ],
    );
  }
}
