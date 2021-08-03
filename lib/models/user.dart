class Users {
  String id;
  String nom;
  dynamic score;
  dynamic scoreHier;
  dynamic scoreTotale;
  String date;
  String groupeId;

  Users(
      {this.score,
      this.id,
      this.nom,
      this.scoreHier,
      this.scoreTotale,
      this.date,this.groupeId});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'nom': nom,
      'score': score,
      'scoreHier': scoreHier,
      'scoreTotale': scoreTotale,
      'date': date,
      'groupeId': groupeId
    };
  }

  Users.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        nom = firestoreMap['nom'],
        scoreHier = firestoreMap['scoreHier'],
        scoreTotale = firestoreMap['scoreTotale'],
        date = firestoreMap['date'],
        groupeId = firestoreMap['groupeId'],
        score = firestoreMap['score'];
}
