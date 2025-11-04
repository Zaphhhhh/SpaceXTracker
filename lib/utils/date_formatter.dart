class DateFormatter {
  const DateFormatter();

  String formatDateManually(DateTime? date) {
    if (date == null) {
      return 'Date non spécifiée';
    }
    const List<String> mois = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre',
    ];
    final jour = date.day;
    final nomDuMois = mois[date.month - 1];
    final annee = date.year;
    final heure = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$jour $nomDuMois $annee à $heure:$minute';
  }
}
