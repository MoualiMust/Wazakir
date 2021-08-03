class Tasks {
  String id;
  String nom;
  String description;
  dynamic score;
  dynamic scoreHier;
  dynamic scoreTotale;
  String date;
  int nmbrUser;

  Tasks(
      {this.score,
      this.id,
      this.nom,
      this.description,
      this.nmbrUser,
      this.scoreHier,
      this.scoreTotale,
      this.date});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'nom': nom,
      'score': score,
      'description': description,
      'nmbrUser': nmbrUser,
      'scoreHier': scoreHier,
      'scoreTotale': scoreTotale,
      'date': date
    };
  }

  Tasks.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        nom = firestoreMap['nom'],
        score = firestoreMap['score'],
        nmbrUser = firestoreMap['nmbrUser'],
        scoreHier = firestoreMap['scoreHier'],
        scoreTotale = firestoreMap['scoreTotale'],
        date = firestoreMap['date'],
        description = firestoreMap['description'];
}
